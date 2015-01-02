#
# Cookbook Name:: maczero
# Recipe:: brews
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'homebrew::default'
include_recipe 'homebrew::cask'

# taps
homebrew_tap 'caskroom/versions'
homebrew_tap 'caskroom/fonts'
homebrew_tap 'homebrew/dupes'

# fonts
package 'font-source-code-pro'
package 'font-fantasque-sans-mono'

# quicklook
package 'suspicious-package' # quicklook info for .pkg installers
package 'quicklook-json'
package 'qlstephen'
package 'qlmarkdown'
package 'qlcolorcode'
package 'qlimagesize'
package 'qlvideo'
package 'epubquicklook'

# emacs
package 'xz'
package 'gnutils'
package 'imagemagick'
package 'mailutils'
package 'glib'
package 'emacs' do
  options '--cocoa --with-glib --with-gnutls --with-imagemagick --with-mailutils'
end

execute 'Loading emacs daemon at startup' do
  cwd File.expand_path('~')
  user node['current_user']
  command "ln -sfv /usr/local/opt/emacs/*.plist ~/Library/LaunchAgents && launchctl load ~/Library/LaunchAgents/homebrew.mxcl.emacs.plist"
  not_if { File.exists? File.expand_path("~/Library/LaunchAgents/homebrew.mxcl.emacs.plist") }
end

# development
homebrew_cask 'java'
package 'elasticsearch'

# apps
homebrew_cask "google-chrome"
# homebrew_cask ""
