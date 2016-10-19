BUILD_DIRS := build

.PHONY: all clean bootstrap master slave

all: bootstrap

bootstrap:
	echo "Setup Repository..."
	cp $(BUILD_DIRS)/virt7-docker-common-release.repo /etc/yum.repos.d
	yum -y install --enablerepo=virt7-docker-common-release kubernetes etcd epel-release
	cp /etc/hosts /etc/hosts.backup
	cat $(BUILD_DIRS)/hosts > /etc/hosts
	cat $(BUILD_DIRS)/config > /etc/kubernetes/config
	systemctl disable firewalld
	systemctl stop firewalld

master:
	cat $(BUILD_DIRS)/etcd.conf /etc/etcd/etcd.conf
	cat $(BUILD_DIRS)/apiserver /etc/kubernetes/apiserver
	bash $(BUILD_DIRS)/master.sh

slave:
	cat $(BUILD_DIRS)/kubelet /etc/kubernetes/kubelet
	bash $(BUILD_DIRS)/slave.sh

clean:
	rm /etc/yum.repos.d/virt7-docker-common-release.repo
	rm /etc/hosts
	mv /etc/hosts.backup /etc/hosts
	rm /etc/kubernetes/config
	rm /etc/etcd/etcd.conf
	rm /etc/kubernetes/apiserver
	rm /etc/kubernetes/kubelet
	yum remove -y kubernetes etcd
