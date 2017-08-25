#
# Cookbook:: global_rvm
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'global_rvm::packages'
include_recipe 'global_rvm::install_rvm'
include_recipe 'global_rvm::add_to_users'
include_recipe 'global_rvm::install_rubies'
include_recipe 'global_rvm::install_gems'
include_recipe 'global_rvm::create_gemsets'