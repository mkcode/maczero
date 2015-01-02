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
