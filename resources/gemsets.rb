require_relative '../libraries/helpers'

actions :install
default_action :install

property :name,     String, name_attribute: true
property :rubies,   Hash,   required: true

action :install do
  break unless rvm_exist?

  new_resource.rubies.keys.each do |ruby|
    next unless new_resource.rubies[ruby]['gemsets'] or new_resource.rubies[ruby]['gemsets']&.empty?

    new_resource.rubies[ruby]['gemsets'].each do |new_gemset|
      execute "install gemset: #{new_gemset}@#{ruby}" do
        command "bash -lc 'rvm use #{ruby}@#{new_gemset} --create'"
        not_if  gemset_exist?(ruby, new_gemset)
      end
    end
  end
end

action_class do
  include GlobalRvmHelper
end