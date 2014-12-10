directory "code" do
  path File.expand_path("~/src")
  recursive true
  action :create
  user node['current_user']
end

directory "mi bosillo" do
  path File.expand_path("~/src/back-pocket")
  recursive true
  action :create
  user node['current_user']
end
