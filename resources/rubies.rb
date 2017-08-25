require_relative '../libraries/helpers'

actions :install
default_action :install

property :name,   String, name_attribute: true
property :rubies, Hash,   required: true

action :install do
  break unless rvm_exist?

  new_resource.rubies.keys.each do |ruby|
    next if has_rvm_ruby_version?(ruby)
    
    execute "install RUBY: #{ruby}" do
      command "bash -lc 'rvm install #{ruby}'"
    end
  end
end

action_class do
  include GlobalRvmHelper
end