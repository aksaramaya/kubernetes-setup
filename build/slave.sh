#!/bin/bash
sed -i "s|centos-minion|$HOSTNAME|g" /etc/kubernetes/kubelet
for SERVICES in kube-proxy kubelet docker; do
  systemctl restart $SERVICES
  systemctl enable $SERVICES
  systemctl status $SERVICES
done
