#!/bin/sh

uname -a | grep -q aarch64 && arch=arm64
uname -a | grep -q x86_64 && arch=amd64

apt-get update

# TRC-2 Anti-debugging
apt-get install -y strace

# TRC-4 Dynamic code loading
apt-get install -y upx

# TRC-5 Fileless execution
apt-get install -y python2

# TRC-103 Code injection detected using ptrace
apt-get install -y curl
curl -L -o /tmp/golang.tar.xz "https://go.dev/dl/go1.19.5.linux-$arch.tar.gz" && \
tar -C /usr/local -xzf /tmp/golang.tar.xz && \
update-alternatives --install /usr/bin/go go /usr/local/go/bin/go 1

# k8s service account tokens
mkdir -p /var/run/secrets/kubernetes.io/serviceaccount
mkdir -p /etc/kubernetes/pki
echo "test" > /var/run/secrets/kubernetes.io/serviceaccount/token
echo "test" > /etc/kubernetes/pki/token
echo "test" > /authorized_keys
