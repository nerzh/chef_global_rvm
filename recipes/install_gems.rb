global_rvm_gems 'Install gems' do
  rubies node['global_rvm']['rubies']
end