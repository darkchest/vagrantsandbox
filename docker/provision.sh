apt-get update

command -v docker || {

apt-get upgrade -y
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce

# Configure the docker engine
# Daemon options: https://docs.docker.com/engine/reference/commandline/dockerd/
# Set both unix socket and tcp to make it easy to connect both locally and remote
# You can add TLS for added security (docker-machine does this automagically)
cat > /etc/docker/daemon.json <<END
{
  "hosts": [ 
      "unix://",
      "tcp://0.0.0.0:2375"
  ],
  "experimental": true,
  "debug": true,
  "metrics-addr": "0.0.0.0:9323" 
}
END

# You can't pass both CLI args and use the daemon.json for parameters, 
# so I'm using the RPM systemd unit file because it doesn't pass any args 
# This version changes the following as of 17.03:
#  - Removes Requires=docker.socket
#  - Removes docker.socket from After
#  - Sets LimitNOFILE=infinity
#  - Removes -H fd:// from ExecStart 
wget -O /lib/systemd/system/docker.service https://raw.githubusercontent.com/docker/docker/v17.03.0-ce/contrib/init/systemd/docker.service.rpm
systemctl daemon-reload
systemctl restart docker

# optional tools for learning 
apt-get install -y -q ipvsadm tree
# lsns is helpful from util-linux, this is installed already

}

usermod -aG docker vagrant

#command -v salt || {
#  wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
#  cat "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" > /etc/apt/sources.list.d/saltstack.list
#  apt-get update
#  apt-get install -y salt-master
#  apt-get install -y salt-minion
#}

#mkdir /home/vagrant/jenkins_home
#chown vagrant:vagrant /home/vagrant/jenkins_home
#runuser -l vagrant -c "docker run -d -p 8080:8080 -p 50000:50000 -v /home/vagrant/jenkins_home:/var/jenkins_home --privileged --name jenkins jenkins/jenkins:lts"
