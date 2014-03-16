
# パッケージ取得
# 参考:http://nigohiroki.hatenablog.com/entry/2013/11/03/025405
remote_file "/tmp/#{node['mysql']['file_name']}" do
  source "#{node['mysql']['remote_uri']}"
  not_if { ::File.exists?("/tmp/#{node['mysql']['file_name']}") }
end

bash "install_mysql" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar xf "#{node['mysql']['file_name']}"
  EOH
end

# 競合するので削除する
package "mysql-libs" do
  action :remove
end

# インストール
node['mysql']['rpm'].each do |rpm|
  package rpm[:package_name] do
    action :install
    provider Chef::Provider::Package::Rpm
    source "/tmp/#{rpm[:rpm_file]}"
  end
end

# サーバー起動
service "mysql" do
  action [:start, :enable]
end

# my.cnf
template "my.cnf" do
	path "/usr/my.cnf"
	source "my.cnf.erb"
	mode 0644
	notifies :restart, 'service[mysql]'
end

# 初期パスワード設定
# 参考:http://blog.youyo.info/blog/2013/07/11/chef-mysql56/
script "Secure_Install" do
  interpreter 'bash'
  user "root"
  not_if "mysql -u root -p#{node[:mysql][:password]} -e 'show databases'"
  code <<-EOL
    export Initial_PW=`head -n 1 /root/.mysql_secret |awk '{print $(NF - 0)}'`
    mysql -u root -p${Initial_PW} --connect-expired-password -e "SET PASSWORD FOR root@localhost=PASSWORD('#{node[:mysql][:password]}');"
    mysql -u root -p#{node[:mysql][:password]} -e "SET PASSWORD FOR root@'127.0.0.1'=PASSWORD('#{node[:mysql][:password]}');"
    mysql -u root -p#{node[:mysql][:password]} -e "FLUSH PRIVILEGES;"
  EOL
end