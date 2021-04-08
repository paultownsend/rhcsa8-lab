# vim: ft=ruby

require "io/console"

machine_files = Dir.glob(
  "#{File.dirname(__FILE__)}/.vagrant/machines/**/virtualbox/*")
vagrant_cmd = ARGV[0].match?(/^--/) ? ARGV[1] : ARGV[0]

if machine_files.empty? and vagrant_cmd == "up"
  puts "Enter Red Hat account credentials\n\n"
  print "Username: "
  rh_username = $stdin.gets.chomp
  print "Password: "
  rh_password = $stdin.noecho(&:gets).chomp
  puts "\n"
end

ENV["VAGRANT_EXPERIMENTAL"] = "disks"

Vagrant.configure("2") do |config|
  # create two servers with the same base configuration
  (1..2).each do |i|
    config.vm.define "server#{i}" do |server|
      server.vm.box = "generic/rhel8"
      server.vm.hostname = "server#{i}.vagrant.internal"
      server.vm.network "private_network", ip: "192.168.33.1#{i}"

      server.vm.provider "virtualbox" do |v|
        v.name = "rhcsa8-server#{i}"
        v.memory = 1024
        v.cpus = 1
      end

      # server1 - add a network interface
      if i == 1
        # "auto_config: false" doesn't work so disable the device manually
        server.vm.network "private_network", ip: "192.168.33.21"
        server.vm.provision "shell", inline: <<-SHELL
          nmcli device disconnect eth2
          nmcli connection delete 'Wired connection 1'
          nmcli connection delete 'Wired connection 2'
          sed -i 's/ONBOOT=yes/ONBOOT=no/' /etc/sysconfig/network-scripts/ifcfg-eth2
        SHELL
      end

      # server2 - add some disks
      if i == 2
        server.vm.disk :disk, size: "5GB", name: "server2-disk001"
        server.vm.disk :disk, size: "5GB", name: "server2-disk002"
        server.vm.disk :disk, size: "2GB", name: "server2-disk003"
      end

      server.vm.provision "shell",
        name: "Register system with Red Hat Subscription Manager",
        inline: "subscription-manager register --username #{rh_username} --password #{rh_password} --auto-attach"

      server.trigger.before :destroy do |t|
        t.name = "Unregister system from Red Hat Subscription Manager"
        t.run_remote = {inline: "subscription-manager unregister"}
      end

      server.vm.provision "shell", path: "provision.sh"
    end
  end
end
