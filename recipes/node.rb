# Default global version. Will only set if not set already
default_version = '0.10'

# nvm version strings to install
# leaving out the minor version will install the latest
nvm_install_versions = %w{
  0.10
  0.11
}

# homebrew packages for nvm
nvm_packages = %w{
  openssl
  nvm
}

nvm_dir = "~/.nvm"
nvm_cmd_pre = "export NVM_DIR=#{nvm_dir} && source $(brew --prefix nvm)/nvm.sh &&"

nvm_packages.each do |nvm_pkg|
  package nvm_pkg do
    action :install
  end
end

# nvm install skips install if that version is already installed.
# no need for not_if
nvm_install_versions.each do |nvm_install_version|
  execute "Installing nvm version #{nvm_install_version} via `nvm install`" do
    command "#{nvm_cmd_pre} nvm install #{nvm_install_version}"
    user node['current_user']
  end
end

directory "ensuring permissions on nvm alias" do
  path File.expand_path("~/.nvm/alias")
  action :create
  user node['current_user']
end

execute "Setting nvm default version to #{default_version}" do
  command "#{nvm_cmd_pre} nvm alias default #{default_version} && nvm use default"
  user node['current_user']
  not_if { `#{nvm_cmd_pre} nvm ls`.split.include? 'default' }
end
