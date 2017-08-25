%w[gpg curl sed].each do |pack|
  package(pack) { action :install }
end