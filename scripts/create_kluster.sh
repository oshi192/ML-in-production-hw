
sudo ufw disable
sudo swapoff -a
sudo sed -i '/swap/d' /etc/fstab
sudo cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "++++++++++                                 +++++++++++"
echo "++++++++++  installing.. kubernetes tools  +++++++++++"
echo "++++++++++                                 +++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt install kubeadm=1.20.12-00 kubelet=1.20.12-00 kubectl=1.20.12-00 kubernetes-cni
sudo apt-mark hold kubelet kubeadm kubectl

install_admin_node(){
  sudo kubeadm init --pod-network-cidr=10.244.0.0/16

	mkdir -p $HOME/.kube
	sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
	sudo chown $(id -u):$(id -g) $HOME/.kube/config

	kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/2140ac876ef134e0ed5af15c65e414cf26827915/Documentation/kube-flannel.yml
	kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
  kubectl taint nodes --all node-role.kubernetes.io/master-
}

case $1 in
    "master")

            install_admin_node
            echo ">>>>>>>> master instaled <<<<<<<<<"
            ;;
    "worker")

            echo ">>>>>>>> worker instaled <<<<<<<<<"
            ;;
    *)
            echo "\nUsage: "
            echo "  1. install master node: '$0 master'"
            echo "  2. Install worker node : '$0 worker'"
            echo "  3. Scan system after kubeflow installed: $0 scan_kf\n"
            echo "$0 [master | worker]\n"
            ;;
esac