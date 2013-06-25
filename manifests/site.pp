# Copyright 2013 Zürcher Hochschule für Angewandte Wissenschaften
# All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

node /^devstackfedora18grizzly/ {


	#set if you want to ######
	$trema = false
	##########################
	
	if $trema {
		# enter puppet code
		$source = "https://github.com/nec-openstack/devstack-quantum-nec-openflow.git"
	}
	else {
		$source = "https://github.com/openstack-dev/devstack.git"
	}

	#ensure git is installed
	package { 'git':
		ensure 		=> 'present',
	}

	# clone the devstack repo
	vcsrepo { "/home/vagrant/devstack":
		ensure 		=> present,
		provider 	=> git,
		source 		=> $source,
		user 		=> 'vagrant',
		require 	=> Package["git"],
                revision	=> 'stable/grizzly'
	}

# , http://fedorapeople.org/groups/heat/prebuilt-jeos-images/F16-x86_64-cfntools.qcow2,http://fedorapeople.org/groups/heat/prebuilt-jeos-images/F16-i386-cfntools.qcow2'"
# ENABLED_SERVICES+=,heat,h-api,h-api-cfn,h-api-cw,h-eng
	$localrc_cnt = "
disable_service rabbit
enable_service qpid
disable_service mysql
enable_service postgresql
ADMIN_PASSWORD=admin
SERVICE_PASSWORD=admin
SERVICE_TOKEN=admin
DATABASE_PASSWORD=admin
APACHE_USER=vagrant
API_RATE_LIMIT=False
HOST_IP=10.1.2.3
FLOATING_RANGE=10.1.2.224/27
#CUSTOMIZATIONS
LOGFILE=/tmp/DEVSTACK/logs/stack.log
SCREEN_LOGDIR=/tmp/DEVSTACK/logs/screen_logs
API_RATE_LIMIT=False
# Compute Service
NOVA_BRANCH=stable/grizzly
# # Volume Service
CINDER_BRANCH=stable/grizzly
# # Image Service
GLANCE_BRANCH=stable/grizzly
# # Web UI (Dashboard)
HORIZON_BRANCH=stable/grizzly
# # Auth Services
KEYSTONE_BRANCH=stable/grizzly
# # Quantum (Network) service
QUANTUM_BRANCH=stable/grizzly
#END_CUSTOMIZATIONS
IMAGE_URLS+='http://uec-images.ubuntu.com/precise/current/precise-server-cloudimg-amd64-disk1.img'"

    file { "/home/vagrant/devstack/localrc":
      content 	=> "$localrc_cnt",
      require 	=> Vcsrepo["/home/vagrant/devstack"],
      group		=> "vagrant",
      owner		=> "vagrant",
    }

	#run stack.sh as current user (vagrant)
	exec { "/home/vagrant/devstack/stack.sh":
		cwd     	=> "/home/vagrant/devstack",
		group		=> "root",
		user		=> "root",
		logoutput	=> on_failure,
		timeout		=> 0, # stack.sh takes time!
		require 	=> File["/home/vagrant/devstack/localrc"],
	}
}
