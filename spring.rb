require 'spring-commands-rspec'                                         
require 'spring-commands-testunit'
Spring.watch 'spec/factories.rb'
Spring.watch 'test/factories.rb'
# Fix AssociationTypeMismatch errors when using STI campaigns;
Spring.after_fork { FactoryGirl.reload if defined?(FactoryGirl) }
