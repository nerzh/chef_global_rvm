require_relative '../libraries/helpers'

actions :install
default_action :install

property :name,   String, name_attribute: true
property :rubies, Hash,   required: true

action :install do
  break unless rvm_exist?

 new_resource.rubies.keys.each do |ruby|
  next unless new_resource.rubies[ruby]['gems'] or new_resource.rubies[ruby]['gems']&.empty?

  new_resource.rubies[ruby]['gems'].each do |new_gem|
    gem_name = new_gem.keys.first
      execute "install gem: #{gem_name}" do
        if new_gem[gem_name] != 'latest'
          break if check_gem_version(ruby, gem_name, new_gem[gem_name])
          command "bash -lc 'rvm use #{ruby}; gem install #{gem_name} -v #{new_gem[gem_name]}'"
        else
          break if check_gem_version(ruby, gem_name)
          command "bash -lc 'rvm use #{ruby}; gem install #{gem_name}'"
        end
      end
    end
  end
end

action_class do
  include GlobalRvmHelper
end