#!/usr/bin/bash

function install_kubectl() {
	# install kubectl
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
	echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c
	install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
	kubectl version --client
}

function install_minikube() {
	# install minikube
	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	install minikube-linux-amd64 /usr/local/bin/minikube
	echo "------------------------------------------- install minikube done!"
}

install_minikube

# alias
echo "alias k='kubectl'" >> ~/.bashrc
echo "alias m='minikube'" >> ~/.bashrc
echo "alias which='command -v'" >> ~/.bashrc
source /root/.bashrc
echo "------------------------------------------- alias done!"

yum install bash-completion
kubectl completion bash > /tmp/completion1.sh
source /tmp/completion1.sh
kubectl completion bash | sed 's/kubectl/k/g' > /tmp/completion2.sh
source /tmp/completion2.sh
echo "------------------------------------------- install completion done!"

# minikube start 2 nodes
minikube start --force
minikube node add
minikube node list
echo "------------------------------------------- minikube start done!"

echo "all done!"





