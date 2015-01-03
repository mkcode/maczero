# emacs
package 'xz'
package 'gnutls'
package 'imagemagick'
package 'mailutils'
package 'glib'
package 'emacs' do
  options '--cocoa --with-glib --with-gnutls --with-imagemagick --with-mailutils'
end

execute 'link emacs.app' do
  cwd File.expand_path('~')
  user node['current_user']
  command "brew linkapps emacs"
  not_if { File.exists? File.expand_path("~/Applications/Emacs.app") }
end

execute 'Loading emacs daemon at startup' do
  cwd File.expand_path('~')
  user node['current_user']
  command "ln -sfv /usr/local/opt/emacs/*.plist ~/Library/LaunchAgents"
  not_if { File.exists? File.expand_path("~/Library/LaunchAgents/homebrew.mxcl.emacs.plist") }
end

git "get emacs repo from git" do
  repository "https://github.com/mkcode/spacemacs"
  destination File.join(node['projects_personal_dir'], "spacemacs")
  revision 'master'
  action :sync
  enable_submodules true
  user node['current_user']
end

link '~/.emacs.d' do
  target_file File.expand_path("~/.emacs.d")
  to File.join(node['projects_personal_dir'], "spacemacs")
  user node['current_user']
end
