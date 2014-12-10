local_mode        true
chef_zero.enabled true
cache_path        File.join(File.expand_path('.'), 'tmp')

# Disable the Passwd plugin which sets 'current_user'
# This is so we can manually set current_user to the login user
# while running under sudo with root privileges 
Ohai::Config[:disabled_plugins] = [ :Passwd ]



