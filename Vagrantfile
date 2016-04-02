# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  # Box name
  config.vm.hostname ="laravelbox.dev"

  # Box memory
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  # Box provision
  config.vm.provision :shell, path:"vagrant_config/install.sh"

  # Networking
  config.vm.network "private_network", ip: "192.168.33.110"

  # Sync folders
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "vagrant_config", "/home/vagrant/config"
  config.vm.synced_folder "projects", "/var/www/projects", owner: "vagrant", group: "www-data", mount_options: ["dmode=777,fmode=777"]

  # Plugins
  required_plugins = %w(vagrant-hostmanager)

 plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
 if not plugins_to_install.empty?
   puts "Installing plugins: #{plugins_to_install.join(' ')}"
   if system "vagrant plugin install #{plugins_to_install.join(' ')}"
     exec "vagrant #{ARGV.join(' ')}"
   else
     abort "Installation of one or more plugins has failed. Aborting."
   end
 end


  # Host Manager

  if Vagrant.has_plugin?('vagrant-hostmanager')
   config.hostmanager.enabled = true
   config.hostmanager.manage_host = false
   config.hostmanager.manage_guest = true
   config.hostmanager.ignore_private_ip = false
   config.hostmanager.include_offline = true
   config.hostmanager.aliases = %w(djangodummy.dev)
 end


end
