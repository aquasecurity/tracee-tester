#!/bin/sh

uname -a | grep -q aarch64 && arch=arm64
uname -a | grep -q x86_64 && arch=amd64

apt-get update

# TRC-2 Anti-debugging
apt-get install -y strace


# TRC-5 Fileless execution
apt-get install -y python2

# TRC-103 Code injection detected using ptrace
apt-get install -y curl
curl -L -o /tmp/golang.tar.xz "https://go.dev/dl/go1.19.5.linux-$arch.tar.gz" && \
tar -C /usr/local -xzf /tmp/golang.tar.xz && \
update-alternatives --install /usr/bin/go go /usr/local/go/bin/go 1

# TRC-1010 Cgroups release agent file modification
# Using an older version of cdk because the latest version doesn't work; see:
# https://github.com/cdk-team/CDK/blob/b0ca845156bd9ef8c2d2ce13ab33699f04b9047d/pkg/exploit/mount_cgroup.go#L198-L210
curl -L -o /usr/bin/cdk "https://github.com/cdk-team/CDK/releases/download/v1.0.5/cdk_linux_$arch" && \
chmod +x /usr/bin/cdk

# k8s service account tokens
mkdir -p /var/run/secrets/kubernetes.io/serviceaccount
mkdir -p /etc/kubernetes/pki
echo "test" > /var/run/secrets/kubernetes.io/serviceaccount/token
echo "test" > /etc/kubernetes/pki/token
echo "test" > /authorized_keys
