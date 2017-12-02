Table of Contents
=================
<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

   * [1. Requirements](#1-requirements)
   * [2. Background Knowledge](#2-background-knowledge)
   * [3. Procedures](#3-procedures)
      * [3.1 Start env](#31-start-env)
      * [3.2 Create volume](#32-create-volume)
      * [3.3 Start mysql server service](#33-start-mysql-server-service)
      * [3.4 Start mysql client service](#34-start-mysql-client-service)
      * [3.5 Mysql server resilient test](#35-mysql-server-resilient-test)
      * [3.6 Destroy env](#36-destroy-env)
   * [4. Highlights](#4-highlights)
   * [5. More resources](#5-more-resources)

# 1. Requirements
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
```
1. Use yaml to start one mysql server service with 1 instance.
2. Use yaml to start one mysql client service with 2 instances.
3. Verify mysql server resilience.
   Delete the instance, confirm another one will be started with no data loss.
```

# 2. Background Knowledge

- Use persistent volumes in 3 steps
```
Creating and using a persistent volume is a three step process:

1. Provision: Administrator provision a networked storage in the
cluster, such as AWS ElasticBlockStore volumes. This is called as
PersistentVolume.

2. Request storage: User requests storage for pods by using
claims. Claims can specify levels of resources (CPU and memory),
specific sizes and access modes (e.g. can be mounted once read/write
or many times write only).  This is called as PersistentVolumeClaim.

3. Use claim: Claims are mounted as volumes and used in pods for storage.

https://blog.couchbase.com/stateful-containers-kubernetes-amazon-ebs/
```

# 3. Procedures

To setup mysql service, here we use mysql image in [docker hub](https://hub.docker.com/_/mysql/).

## 3.1 Start env
- Start vm
```
# start a VM to host our deployment
minikube start
```

## 3.2 Create volume
```
# Create PersistentVolume
kubectl create -f ./volume-mysql-server.yml
kubectl get pv

# Create PersistentVolumeClaim
kubectl create -f ./claim-mysql-server.yml
kubectl get pvc
```

## 3.3 Start mysql server service

- Start mysql server service
```
# Docker: https://hub.docker.com/_/mysql/
# Create ReplicationController for mysql server
kubectl create -f ./rc-mysql-server.yml
kubectl get rc

# Start service
kubectl create -f ./service-mysql-server.yml
kubectl get service

# Get status
kubectl get pod
kubectl get services
```

## 3.4 Start mysql client service
```
# Start ReplicationController for mysql client. It will start 2 instances
kubectl create -f ./rc-mysql-client.yml
kubectl get rc

## ,-----------
## | macs-DennyZhang.com:Scenario-102 mac$ kubectl get rc
## | NAME              DESIRED   CURRENT   READY     AGE
## | rc-mysql-client   2         2         2         15s
## | rc-mysql-server   1         1         1         39s
## `-----------

# Start service
kubectl create -f ./service-mysql-client.yml
kubectl get services

# Get status
kubectl get pod
kubectl get services
```

- Check Web UI
```
minikube dashboard
```

- Open mysql client to access the mysql server

TODO

## 3.5 Mysql server resilient test
- If one instance is down, another will be started automatcially.

TODO

## 3.6 Destroy env
```
minikube delete
```

# 4. Highlights
- Q: How does the volume process work?

- Q: How PersistentVolumeClaim know use which PersistentVolume?

# 5. More resources
- minikube: https://kubernetes.io/docs/getting-started-guides/minikube/
- k8s local solutions: https://kubernetes.io/docs/setup/pick-right-solution/#local-machine-solutions
- k8s volume: https://blog.couchbase.com/stateful-containers-kubernetes-amazon-ebs/

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
