gems = %w(bundler rails sqlite3 therubyracer mysql2)
gems.each do |gem|
  gem_package gem do
    action :install
  end
end

# うまく動いてくれないので保留中
#bash 'create rails project' do
#  user 'vagrant'
#  cwd '/vagrant/app/'
#  code <<-EOC
#    rails new #{node['nginx']['application_name']} --database=mysql
#    cd #{node['nginx']['application_name']}
#    bundle install
#    bundle exec rake db:create
#    rails s --daemon
#  EOC
#end