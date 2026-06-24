#!/bin/sh
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_resets=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // empty')

# ANSI color codes
dim="\033[2m"
cyan="\033[36m"
yellow="\033[33m"
green="\033[32m"
magenta="\033[35m"
blue="\033[34m"
reset="\033[0m"

# Git branch (skip optional locks to avoid conflicts)
branch=""
if [ -n "$cwd" ] && git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
fi

# Build output using printf for color support
out=""

# Model — cyan value
if [ -n "$model" ]; then
    out="${cyan}${model}${reset}"
fi

# Context usage — muted label, yellow value
if [ -n "$used_pct" ]; then
    ctx=$(printf "%.0f" "$used_pct")
    out="${out}  ${dim}ctx:${reset}${yellow}${ctx}%${reset}"
fi

# Git branch — muted label, green value
if [ -n "$branch" ]; then
    out="${out}  ${dim}branch:${reset}${green}${branch}${reset}"
fi

# Rate limits — muted labels, magenta values
if [ -n "$five_pct" ]; then
    five_label="$(printf '%.0f' "$five_pct")%"
    if [ -n "$five_resets" ]; then
        now=$(date +%s)
        secs_left=$((five_resets - now))
        if [ "$secs_left" -gt 0 ]; then
            hrs=$((secs_left / 3600))
            mins=$(( (secs_left % 3600) / 60 ))
            five_label="${five_label} ${dim}resets in${reset}${magenta} ${hrs}h${mins}m${reset}"
        fi
    fi
    out="${out}  ${dim}5h:${reset}${magenta}${five_label}"
fi
if [ -n "$week_pct" ]; then
    out="${out}  ${dim}7d:${reset}${blue}$(printf '%.0f' "$week_pct")%${reset}"
fi

printf "%b" "$out"
