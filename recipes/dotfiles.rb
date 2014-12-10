include_recipe 'maczero::directories'

git "dotfiles" do
  repository "https://github.com/mkcode/dotfiles"
  destination File.join(node['projects_personal_dir'], "dotfiles")
  revision 'master'
  action :sync
  user node['current_user']
end

homebrew_tap 'thoughtbot/formulae'
package 'rcm'

execute "setting up dotfiles" do
  command lazy {
    dotfiles_path = File.join(node['projects_personal_dir'], 'dotfiles')
    rcrc_path = File.join(dotfiles_path, 'rcrc')
    rcup_excludes = File.read(rcrc_path).match(/EXCLUDES=\"(.*)\"/)[1]
    rcup_ex_str = rcup_excludes.split.join(' -x ')
    rcup_ex_str = 'README.md' if rcup_ex_str.length == 0 # catch fails
    "rcup -d #{dotfiles_path} -x #{rcup_ex_str}"
  }
  user node['current_user']
  not_if { File.exists? File.expand_path("~/.rcrc") }
end
