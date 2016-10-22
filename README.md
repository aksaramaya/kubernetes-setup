# Frak You Kubernetes

Clone :
```bash
$ git clone https://github.com/aksaramaya/kubernetes-setup.git
```

## Bootstrap

Replace host IP with your environment at `build/host` file. Add master and node to /etc/hosts on all machines (not needed if hostnames already in DNS)

Example :
```bash
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.7.11 ak-master #your master IP Address
192.168.7.12 ak-node1
192.168.7.13 ak-node2
192.168.7.14 ak-node3
```
install kubernetes to all node :

```bash
$ sudo make
or
$ sudo make bootstrap
```

## Frak the master
```bash
$ ssh frak@192.168.7.11
$ sudo make master
```

## Frak the nodes
```bash
$ sudo make slave
```

# Kubernetes Vagrant
```bash
$ git clone https://github.com/aksaramaya/kubernetes-setup.git
$ cd kubernetes-setup
$ vagrant up
```
