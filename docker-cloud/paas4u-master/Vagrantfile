ANSIBLE_GROUPS = {
              "master" => ["node1"],
              "nodes" => ["node2"],
              "all_groups:children" => ["master", "nodes"]
            }

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.define "node1" do |node1|
      node1.vm.network "private_network", ip: "192.168.33.10"
      node1.vm.hostname = "node1"
      node1.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--memory", "2012"]
	v.customize ["modifyvm", :id, "--cpus", "1"]
      end
      node1.vm.provision "ansible" do |ansible|
        ansible.playbook = "playbook.yml"
        ansible.groups = ANSIBLE_GROUPS
      end
  end

  config.vm.define "node2" do |node2|
      node2.vm.network "private_network", ip: "192.168.33.11"
      node2.vm.hostname = "node2"
      node2.vm.provider "virtualbox" do |v|
         v.customize ["modifyvm", :id, "--memory", "1024"]
         v.customize ["modifyvm", :id, "--cpus", "1"]
      end
      node2.vm.provision "ansible" do |ansible|
        ansible.playbook = "playbook.yml"
        ansible.groups = ANSIBLE_GROUPS
      end
  end
end
