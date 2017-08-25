module GlobalRvmHelper
  def rvm_exist?
    `bash -lc 'which rvm'` != ''
  end

  def belong_to_rvm_group?(user)
    `bash -lc 'groups #{user}'`.split(' ').include?('rvm')
  end

  def has_rvm_ruby_version?(version)
    `bash -lc 'rvm list strings'`[/ruby-#{version}/] != nil
  end

  def check_gem_version(ruby_v, gem_name, gem_v=nil)
    if gem_v
      return `bash -lc 'rvm use #{ruby_v}; gem list -i #{gem_name} -v #{gem_v}'`.split("\n").last == 'true'
    else
      return `bash -lc 'rvm use #{ruby_v}; gem list -i #{gem_name}'`.split("\n").last == 'true'
    end
  end

  def gemset_exist?(ruby_v, name)
    `bash -lc 'rvm use #{ruby_v}; rvm gemset list'`.split("\n").map{|el| el.strip}.include?(name).to_s
  end
end