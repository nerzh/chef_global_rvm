require_relative '../libraries/helpers'

actions :install
default_action :install

property :name,     String, name_attribute: true
property :users,    Array,  required: true
property :rvm_path, String, required: true

action :install do
  break if rvm_exist?

  users.each do |user|
    next if belong_to_rvm_group?(user)

    ruby_block "export rvm_path #{rvm_path} to /etc/profile" do
      rvm_export_path        = "export rvm_path=#{rvm_path}"
      rvm_export_path_regexp = /rvm/

      block do
        file = Chef::Util::FileEdit.new('/etc/profile')
        file.insert_line_if_no_match(rvm_export_path_regexp, "\n#{rvm_export_path}")
        file.write_file
      end
    end

    execute "add rvm to user: #{user}" do
      command "gpasswd -a #{user} rvm"
    end
  end
end

action_class do
  include GlobalRvmHelper
end