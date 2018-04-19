apt-get update
apt-get install -y python python-pip tree

command -v docker || {

apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce

}

usermod -aG docker vagrant

command -v java || {

apt-get update
#apt-get install -y openjdk-8-jdk
apt-get install -y software-properties-common
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
apt-get install -y oracle-java9-installer
apt-get install -y oracle-java9-set-default
}

command -v ansible || {

apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get install -y ansible

}

pip install --upgrade pip
pip install boto3 netaddr

