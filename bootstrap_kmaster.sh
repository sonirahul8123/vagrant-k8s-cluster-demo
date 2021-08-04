#!/bin/bash

echo "[TASK 1] Initialize Kubernetes Cluster"
kubeadm init --apiserver-advertise-address=192.168.33.100 --pod-network-cidr=192.168.0.0/16 >> /root/kubeinit.log 2>/dev/null

echo "[TASK 2] Copy kube admin config to vagrant user .kube directory"
mkdir /home/vagrant/.kube
cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube

echo "[TASK 3] Deploy Calico network"
su - vagrant -c "kubectl create -f https://docs.projectcalico.org/v3.9/manifests/calico.yaml" >/dev/null 2>&1

echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > /joincluster.sh 2>/dev/null
