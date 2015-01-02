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

directory '/opt/homebrew-cask/Caskroom' do
  action :create
  recursive true
  mode '0755'
  owner node['current_user']
  group 'staff'
end

directory '/opt/homebrew-cask' do
  owner node['current_user']
end

# taps
homebrew_tap 'caskroom/versions'
homebrew_tap 'caskroom/fonts'
homebrew_tap 'homebrew/dupes'

# fonts
homebrew_cask 'font-source-code-pro'
homebrew_cask 'font-fantasque-sans-mono'

# quicklook
homebrew_cask 'suspicious-package' # quicklook info for .pkg installers
homebrew_cask 'quicklook-json'
homebrew_cask 'qlstephen'
homebrew_cask 'qlmarkdown'
homebrew_cask 'qlcolorcode'
homebrew_cask 'qlimagesize'
homebrew_cask 'qlvideo'
homebrew_cask 'epubquicklook'

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

# development
homebrew_cask 'java'
package 'elasticsearch'

# apps
homebrew_cask "google-chrome"
homebrew_cask "google-chrome-canary"
homebrew_cask "firefox"
homebrew_cask "grandperspective"
homebrew_cask "flux"
homebrew_cask "fseventer"
# homebrew_cask ""
