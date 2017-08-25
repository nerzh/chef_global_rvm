require_relative '../libraries/helpers'

actions :install
default_action :install

property :name,                 String, name_attribute: true
property :rvm_path,             String, required: true
property :install_requirements, [TrueClass, FalseClass, String], default: false

action :install do
  break if rvm_exist?

  execute "add gpg keys rvm" do
    command "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB"
  end

  execute "install RVM to #{new_resource.rvm_path}" do
    command "export rvm_path=#{new_resource.rvm_path}; curl -L get.rvm.io | bash -s stable"
  end

  if new_resource.install_requirements.to_s == true
    execute "install rvm requirements" do
      command "sudo -i -H -u root bash -c 'rvm requirements'"
    end
  end
end

action_class do
  include GlobalRvmHelper
end