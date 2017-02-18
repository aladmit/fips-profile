Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.ssh.username = "root"
  config.ssh.password = "vagrant"

  config.vm.define "virtualbox" do |virtualbox|
    virtualbox.vm.hostname = "virtualbox-centos7"
    virtualbox.vm.box = "file://packer/builds/virtualbox-centos7.box"

    config.vm.provider :virtualbox do |v|
      v.gui = false
      v.memory = 1024
      v.cpus = 1
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--ioapic", "on"]
    end
  end
end
