# -*- mode: ruby -*-
# vi: set ft=ruby :
#
dhostname = "f18libvirt"

Vagrant.configure("2") do |config|
  config.vm.box = "f18libvirt"
  config.vm.hostname = dhostname
  config.vm.define :test_vm do |test_vm|
    test_vm.vm.box = "f18libvirt"
    test_vm.vm.box_url = "http://file.rdu.redhat.com/~whayutin/f18_libvirt/f18libvirt.box" 
    #test_vm.vm.network :public_network
    test_vm.vm.network :private_network
    #test_vm.vm.network :private_network, :ip => '10.20.30.45'
    #test_vm.vm.network :private_network, :ip => '10.20.30.45'
    #test_vm.vm.network :forwarded_port, guest: 80, host: 8080
    #test_vm.vm.network :forwarded_port, guest: 443, host: 8443
    #test_vm.vm.synced_folder  "manifests/", "/tmp/vagrant-puppet"
  end

  config.vm.provider :libvirt do |libvirt|
    libvirt.driver = "qemu"
    libvirt.host = "localhost"
    libvirt.connect_via_ssh = true
    libvirt.username = "root"
    libvirt.storage_pool_name = "default"
  end 
  
  
  config.vm.provision :puppet do |devstack_puppet|
    devstack_puppet.pp_path = "/tmp/vagrant-puppet"
    devstack_puppet.module_path = "modules"
    devstack_puppet.manifests_path = "manifests"
    devstack_puppet.manifest_file = "site.pp"
    devstack_puppet.facter = { "fqdn" => dhostname }
  end
 
  #config.vm.provision :puppet_server do |puppet|
  #  #puppet.puppet_server = "puppet.example.com"
  #  puppet.puppet_node = dhostname
  #end

  #config.vm.provision :puppet_server, :options => "--verbose --debug"
 
   #config.vm.synced_folder ".", "/tmp/vagrant"
   #config.ssh.default.username = "vagrant"

  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  #config.vm.box = "base"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file base.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  #
  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision :chef_solo do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision :chef_client do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
