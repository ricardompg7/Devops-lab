#/bin/sh
sudo yum -y install epel-release
echo "Instalando o Ansible no Control Node"
sudo yum -y install ansible
cat <<EOT >> /etc/hosts
192.168.1.2 control-node
192.168.1.3 app01
192.168.1.2 db01
EOT
