#
# File: Vagrantfile
# 
# By: Daniel Morales <daniminas@gmail.com>
#
# Web: https://github.com/danielm/sinatra-rest-server
#
# Licence: GPL/MIT

# Configuration file version
Vagrant.configure(2) do |config|

  # Box
  config.vm.box = "ubuntu/xenial64"

  # This forwards Sinatra's 4567 to 8080 on your development pc 
  # and allows you to access http://localhost:8080 in your browser
  config.vm.network "forwarded_port", guest: 4567, host: 8080

  # Provisioning our Box
  config.vm.provision "shell", path: "scripts/provision.sh"
end