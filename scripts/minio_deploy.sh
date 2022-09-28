#!/bin/bash
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++                               ++++++++++++"
echo "+++++++++++   installing... preparing    ++++++++++++"
echo "+++++++++++                               ++++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++"
sudo apt install libarchive-tools

sudo apt install wget

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++                               ++++++++++++"
echo "+++++++++++     installing... minio       ++++++++++++"
echo "+++++++++++                               ++++++++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++"

wget -qO- https://github.com/minio/operator/releases/latest/download/kubectl-minio_linux_amd64.zip | sudo bsdtar -xvf- -C /usr/local/bin
sudo chmod +x /usr/local/bin/kubectl-minio

echo "======================================================"
echo "============                              ============"
echo "==========   configuring space for minio    =========="
echo "============                              ============"
echo "======================================================"
kubectl create namespace minio-tenant-1
sudo kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.22/deploy/local-path-storage.yaml
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
kubectl minio init
Retries_count=5
printf "\nWaiting console pod until it be ready "
sleep 5
while [ $(kubectl get deployment -n minio-operator console -o 'jsonpath={..status.readyReplicas}') -eq 0 ];
  do
    printf "#"
    Retries_count=$(( Retries_count - 1 ))
    if [ "$Retries_count" -le 0 ]; then
        printf "\nFailed installing minio-console by timeout.\n"
        exit 1
    fi
    sleep 20
  done

printf "\nReady!\n"

