#!bin/bash

## Load system modules that allow for bridged traffic 
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

## Disable swap
sudo swapoff -a

## Packets go through iptables
## Enable IP forwarding
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Restart
sudo sysctl --system

#Add K8s Repository to apt registration
sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

## Install packages to manage cluster components
sudo apt-get update && sudo apt-get install -y kubelet kubeadm kubectl  

## Enable kubelet as a service
sudo systemctl enable --now kubelet

## Change kubelet configuration to use systemd as a cgroupDriver
# kubeadm assigns systemd by default 
#cat <<EOF | sudo tee /var/lib/kubelet/config.yaml 
#apiVersion: kubelet.config.k8s.io/v1beta1    
#kind: KubeletConfiguration
#cgroupDriver: systemd
#EOF 

## Reload service configurations
#sudo systemctl daemon-reload
## Restart kubelet
#sudo systemctl restart kubelet


## Install a container runtime -- containerd

## Download containerd binaries 
##wget -c https://github.com/containerd/containerd/releases/download/v1.7.12/containerd-1.7.12-linux-amd64.tar.gz
##tar xfvz containerd-1.7.12-linux-amd64.tar.gz

## Download runc and statically linked libraries
##wget -c https://github.com/opencontainers/runc/releases/download/v1.1.11/libseccomp-2.5.4.tar.gz
##wget -c https://github.com/opencontainers/runc/releases/download/v1.1.11/runc.amd64

##tar xfvz libseccomp-2.5.4.tar.gz
##install -m 755 runc.amd64 /usr/local/sbin/runc

## Install network plugins
wget -c https://github.com/containernetworking/plugins/releases/download/v1.4.0/cni-plugins-linux-amd64-v1.4.0.tgz
sudo tar xfvz cni-plugins-linux-amd64-v1.4.0.tgz

## Initialize with systemd
curl https://raw.githubusercontent.com/containerd/containerd/main/containerd.service >> /usr/lib/systemd/system/containerd.service

## Add a config.toml
sudo apt-get update && sudo apt-get install -y containerd 
sudo mkdir -p /etc/containerd
sudo chown -R $(whoami) /etc/containerd
sudo chmod -R 777 /etc/containerd
sudo containerd config default > /etc/containerd/config.toml

## Restart
sudo systemctl daemon-reload
sudo systemctl enable --now containerd

## On Control Plane Node Only
 # kubeadm init

 # mkdir -p $HOME/.kube
 # sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
 # sudo chown $(id -u):$(id -g) $HOME/.kube/config


