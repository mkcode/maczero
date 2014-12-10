require 'etc'

default['current_user'] = Etc.getlogin


default['projects_dir'] = File.expand_path('~/src')
default['projects_personal_dir'] = File.expand_path('~/src/pocket')
