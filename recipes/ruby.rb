# Default global version. Will only set if not set already
global_version = '2.1.2'

# ruby-build version strings to install
ruby_build_versions = %w{
  2.1.2
  2.2.0-dev
}

# homebrew packages for rbenv
rbenv_packages = %w{
  openssl
  readline
  libyaml
  rbenv
  rbenv-gem-rehash
  rbenv-bundler
  ctags
  rbenv-ctags
  ruby-build
}

rbenv_packages.each do |pkg|
  package pkg do
    action :install
  end
end

execute "installing rbenv-default-gems" do
  command "brew install https://raw.githubusercontent.com/mkcode/rbenv-default-gems/master/formula/rbenv-default-gems.rb --HEAD"
  user node['current_user']
end

rbenv_pre_cmd = 'eval "$(rbenv init -)" &&'

ruby_build_versions.each do |ruby_build_version|
  execute "Installing ruby version #{ruby_build_version} via `rbenv install`" do
    cwd File.expand_path('~')
    command "sudo -u #{node['current_user']} -s '#{rbenv_pre_cmd} rbenv install #{ruby_build_version} --skip-existing'"
    user node['current_user']
  end
end

execute "Setting rbenv global version to #{global_version}" do
  command "#{rbenv_pre_cmd} rbenv global #{global_version}"
  user node['current_user']
  only_if { `rbenv global`.split.include? 'system' }
end
