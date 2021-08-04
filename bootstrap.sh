#!/bin/bash

echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
192.168.33.100   kmaster.example.com     kmaster
192.168.33.101   kworker1.example.com    kworker1
192.168.33.102   kworker2.example.com    kworker2
EOF

echo "[TASK 2] Install docker container engine"
apt-get install -y apt-transport-https ca-certificates curl software-properties-common >/dev/null 2>&1
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - >/dev/null 2>&1
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" >/dev/null 2>&1
apt-get update -y >/dev/null 2>&1
apt-get install -y docker-ce >/dev/null 2>&1

# Add vagrant user in docker group 
usermod -aG docker vagrant >/dev/null 2>&1

# Enable docker service
echo "[TASK 3] Enable and start docker service"
systemctl enable docker >/dev/null 2>&1
systemctl start docker >/dev/null 2>&1

# Add sysctl settings
echo "[TASK 4] Add Kernel settings"
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
EOF
sysctl --system >/dev/null 2>&1

# Disable swap
echo "[TASK 5] Disable and turn off SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a

echo "[TASK 6] Installing apt-transport-https pkg" 
apt-get update -y  >/dev/null 2>&1 && apt-get install -y apt-transport-https curl  >/dev/null 2>&1
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - >/dev/null 2>&1

sudo touch /etc/apt/sources.list.d/kubernetes.list
cat >>/etc/apt/sources.list.d/kubernetes.list<<EOF
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update -y >/dev/null 2>&1

# Install Kubernetes
echo "[TASK 7] Install Kubernetes kubeadm kubelet kubectl"
apt-get install -y kubelet kubeadm kubectl >/dev/null 2>&1

# Start and Enable kubelet service
echo "[TASK 8] Start and Enable kubelet service"
systemctl enable kubelet >/dev/null 2>&1
systemctl start kubelet >/dev/null 2>&1

echo "[TASK 9] Enable ssh password authentication"
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart sshd >/dev/null 2>&1

echo "[TASK 10] Set root password"
echo -e "kubeadmin\nkubeadmin" | passwd root >/dev/null 2>&1
echo "export TERM=xterm" >> /etc/bashrc >/dev/null 2>&1
