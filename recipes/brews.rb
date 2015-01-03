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

# development
homebrew_cask 'java'
package 'elasticsearch'

# apps
homebrew_cask "iterm2"
homebrew_cask "google-chrome"
homebrew_cask "google-chrome-canary"
# homebrew_cask "firefox"
homebrew_cask "grandperspective"
homebrew_cask "flux"
homebrew_cask "fseventer"
homebrew_cask "vmware-fusion"
homebrew_cask "launchbar"
homebrew_cask "licecap"
homebrew_cask "mjolnir"
homebrew_cask "notational-velocity"
homebrew_cask "screenhero"




# homebrew_cask ""
