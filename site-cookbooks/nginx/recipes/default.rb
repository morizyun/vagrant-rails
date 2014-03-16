package 'nginx' do
  action :install
  options '--enablerepo=nginx'
end

service 'nginx' do
  supports :status => true,
           :restart => true,
           :reload => true
  action [:enable, :start]
end

template 'nginx.conf' do
  path '/etc/nginx/nginx.conf'
  source 'nginx.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :reload , 'service[nginx]'
end

directory '/etc/nginx/sites-enabled' do
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

template '/etc/nginx/sites-enabled/default.conf' do
  source 'sites-enabled.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :reload, 'service[nginx]'
end