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
}


#install_kubectl
install_minikube

# alias
# alias k='kubectl'
# alias m='minikube'
echo "alias k='kubectl'" >> ~/.bashrc
echo "alias m='minikube'" >> ~/.bashrc
echo "alias which='command -v'" >> ~/.bashrc

yum install bash-completion
echo 'source <(kubectl completion bash)' >>~/.bashrc
source ~/.bashrc
source <(kubectl completion bash | sed s/kubectl/k/g)

# minikube start 2 nodes
minikube start
minikube node add
minikube node list






