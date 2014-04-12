# Vagrantfile with CentOS 6.5/ruby 2.1.0/MySQL/Nginx

_Description: Vagrantfile with CentOS 6.5/ruby 2.1.0/MySQL/Nginx

## Project Setup

1. Download and install Vagrant http://www.vagrantup.com/

2. `vagrant plugin install vagrant-omnibus`

3. Download and install VirtualBox https://www.virtualbox.org/

4. `git clone https://github.com/morizyun/vagrant-rails`

5. `cd vagrant-rails`

6. `bundle install`

7. `bundle exec berks install --path site-cookbooks`

8. `vagrant up`

9. create rails project

```
vagrant ssh
cd /vagrant/app
rails new chef_rails --database=mysql
cd chef_rails
echo "gem 'therubyracer', platforms: :ruby" >> Gemfile
bundle install
bundle exec rake db:create
rails s
```

10. Browsing `http://192.168.33.10/`

## Basic information

1. Sync Folder(Sever - Local) : `/vagrant/app` - `app/`

2. MySQL ROOT PASS : ``(nothing)