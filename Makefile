BUILD_DIRS := build

.PHONY: all clean bootstrap master slave

all: bootstrap

bootstrap:
	echo "Setup Repository..."
	cp $(BUILD_DIRS)/virt7-docker-common-release.repo /etc/yum.repos.d
	yum -y install --enablerepo=virt7-docker-common-release kubernetes etcd flannel epel-release 
	cp /etc/hosts /etc/hosts.backup
	cat $(BUILD_DIRS)/hosts > /etc/hosts
	cat $(BUILD_DIRS)/config > /etc/kubernetes/config
	systemctl disable firewalld
	systemctl stop firewalld

master:
	cat $(BUILD_DIRS)/etcd.conf > /etc/etcd/etcd.conf
	cat $(BUILD_DIRS)/apiserver > /etc/kubernetes/apiserver
	#/usr/bin/etcdctl mkdir /kube-centos/network
	#/usr/bin/etcdctl mk /kube-centos/network/config "{ \"Network\": \"172.30.0.0/16\", \"SubnetLen\": 24, \"Backend\": { \"Type\": \"vxlan\" } }"
	etcdctl mk /atomic.io/network/config '{"Network":"172.17.0.0/16"}'
	bash $(BUILD_DIRS)/master.sh

slave:
	cat $(BUILD_DIRS)/kubelet > /etc/kubernetes/kubelet
	bash $(BUILD_DIRS)/slave.sh

clean:
	rm /etc/yum.repos.d/virt7-docker-common-release.repo
	rm /etc/hosts
	mv /etc/hosts.backup /etc/hosts
	rm /etc/kubernetes/config
	rm /etc/etcd/etcd.conf
	rm /etc/kubernetes/apiserver
	rm /etc/kubernetes/kubelet
	yum remove -y kubernetes etcd docker docker-common docker-selinux
	rm -rf /var/lib/docker/
