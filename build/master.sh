#!/bin/bash
for SERVICES in etcd kube-apiserver kube-controller-manager kube-scheduler flanneld; do
  systemctl restart $SERVICES
  systemctl enable $SERVICES
  systemctl status $SERVICES
done
