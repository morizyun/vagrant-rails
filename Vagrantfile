# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'CentOS_6.5_x86_64'
  config.vm.box_url = 'http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.5-x86_64-v20140110.box'

  config.vm.network :private_network, ip: '192.168.33.10'

  # cakephpを使うために必要
  config.vm.synced_folder './', '/vagrant', mount_options: ['dmode=777', 'fmode=666']

  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.log_level = :debug
    chef.cookbooks_path = './site-cookbooks'
    chef.run_list = %w(base nginx mysql56 database ruby_build rbenv::system ruby_gem)

    chef.json = {
        mysql: {
            password: ''
        },
        rbenv: {
            rubies: ['2.1.0'],
            global: '2.1.0',
            gems: {
                '2.1.0' => [
                    {
                        name: 'bundler',
                        options: '--no-ri --no-rdoc'
                    },
                    {
                        name: 'rails',
                        options: '--no-ri --no-rdoc'
                    }
                ]
            }
        },
        nginx: {
            application: 'chef_rails',
        }
    }
  end
end
