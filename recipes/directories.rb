directory "code" do
  path node['projects_dir']
  recursive true
  action :create
  user node['current_user']
end

directory "mi bosillo" do
  path node['projects_personal_dir']
  recursive true
  action :create
  user node['current_user']
end
