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
  destination File.expand_path("~/src/back-pocket/prezto")
  revision 'my-config'
  action :sync
  enable_submodules true
  user node['current_user']
end

link 'link prezto to home' do
  target_file File.expand_path('~/.zprezto')
  to File.expand_path('~/src/back-pocket/prezto')
  user node['current_user']
end

execute "setting up home" do
  command "rcup -d ~/src/back-pocket/prezto/runcoms"
  user node['current_user']
  not_if { File.exists? "~/.zprezto" }
end

user node['current_user'] do
  action :modify
  shell lazy{ `brew --prefix zsh` }
end
