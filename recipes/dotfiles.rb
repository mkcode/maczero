include_recipe 'provision::directories'

git "dotfiles" do
  repository "https://github.com/mkcode/dotfiles"
  destination File.expand_path("~/src/back-pocket/dotfiles")
  revision 'master'
  action :sync
  user node['current_user']
end

homebrewalt_tap 'thoughtbot/formulae'
package 'rcm'

execute "setting up dotfiles" do
  command lazy {
    rcrc_path = File.expand_path('~/src/back-pocket/dotfiles/rcrc')
    rcup_excludes = File.read(rcrc_path).match(/EXCLUDES=\"(.*)\"/)[1]
    rcup_ex_str = rcup_excludes.split.join(' -x ')
    rcup_ex_str = 'README.md' if rcup_ex_str.length == 0 # catch fails
    "rcup -d ~/src/back-pocket/dotfiles -x #{rcup_ex_str}"
  }
  user node['current_user']
  not_if { File.exists? File.expand_path("~/.rcrc") }
end
