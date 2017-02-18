$script = <<SCRIPT
    echo Configure prelinking...
    sudo yum install prelink -y
    sudo prelink -u -a
    sudo echo PRELINKING=no > /etc/sysconfig/prelink
    echo Configure kernel...
    sudo yum install dracut-fips -y
    sudo dracut -f
    echo Configure boot...
    echo 'GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=cl/root rhgb quiet fips=1 boot=/dev/sda1"' >> /etc/default/grub
    sudo grub2-mkconfig -o /boot/grub2/grub.cfg
    echo Configure SSHD...
    echo Protocol 2 >> /etc/ssh/sshd_config
    echo 'Ciphers aes128-ctr,aes192-ctr,aes256-ctr,aes128-cbc,3des-cbc,aes192-cbc,aes256-cbc' >> /etc/ssh/sshd_config
    echo 'Macs hmac-sha1,hmac-sha2-256,hmac-sha2-512' >> /etc/ssh/sshd_config
    echo Done.
    echo Reboot!
    sudo reboot
SCRIPT

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

    config.vm.provision "shell", inline: $script
  end
end
