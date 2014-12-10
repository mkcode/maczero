include_recipe 'maczero::directories'

zsh_packages = %w{
  zsh
  fortune
  fasd
}

zsh_packages.each do |pkg|
  package pkg do
    action :install
  end
end

homebrew_tap 'thoughtbot/formulae'
package 'rcm'

git "prezto (zsh)" do
  repository "https://github.com/mkcode/prezto"
  destination File.join(node['projects_personal_dir'], "prezto")
  revision 'my-config'
  action :sync
  enable_submodules true
  user node['current_user']
end

link 'link prezto to home' do
  target_file File.expand_path('~/.zprezto')
  to File.join(node['projects_personal_dir'], "prezto")
  user node['current_user']
end

execute "setting up home" do
  command "rcup -d #{File.join(node['projects_personal_dir'], 'prezto', 'runcoms' )}"
  user node['current_user']
  not_if { File.exists? "~/.zprezto" }
end

execute "adding brew managed zsh to available shells" do
  command 'echo "$(brew --prefix)/bin/zsh" >> /etc/shells'
  not_if {
    zsh_bin = File.join(`brew --prefix`.chomp, 'bin', 'zsh')
    File.readlines('/etc/shells').detect{ |line| line.chomp == zsh_bin }
  }
end

user node['current_user'] do
  action :modify
  shell lazy{ File.join(`brew --prefix`.chomp, 'bin', 'zsh') }
end
