
=== This is the instslling script of minikube.sh ====

#vim .bashrc
#export PATH=$PATH:/usr/local/bin
#source .bashrc

yum install docker -y
systemctl start docker
systemctl status docker
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo mv kubectl /usr/local/bin/kubectl
sudo chmod +x /usr/local/bin/kubectl
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
sudo yum install iptables -y
yum install conntrack -y
minikube start --driver=docker --force
minikube status 

====================================================================================================================
Setup for minikube

Launch instance and select t2.medium with 20gb of free disk with all traffic.
Create folder vim minikube.sh ----> Add the script in file then type type command sh minikube.sh ----> run the scipt.
then create vim abc.yml --> Add script 
---
apiVersion: App/v1
kind: pod
metadata:
  name: pod1   -----> this is pod name.
spec: null
containers:
  - image: nginx
    name: cont1
---------------------------------------------------------------------------------------------------------
Then create kubectl create -f abc.yml ----> pod created
remove pod then ----> kubectl delete pod pod1
kubectl get po ----> It show the pod will run or not.

then edit the file vim abc.yml

apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: train-replicaset
  labels:
    app: train
spec:
  replicas: 3
  selector:
    matchLabels:
      app: train
  template:
    metadata:
      labels:
        app: train
    spec:
      containers:
        - name: cont1
          image: nginx

Then type command  ---> kubectl create -f abc.yml
kubectl get rs ----> it show the replicaset
kubectl get rs -o wide ----> it show the complete info about replicaset.
kubectl scale rs/train-replicaset --replicas=10   ----> it create the 10 pods.

