global_rvm_users 'Add users to rvm group' do
  users    node['global_rvm']['users']
  rvm_path node['global_rvm']['rvm_path']
end