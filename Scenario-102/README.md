Table of Contents
=================
<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

   * [1. Requirements](#1-requirements)
   * [2. Procedures](#2-procedures)
      * [2.1 Start env](#21-start-env)
      * [2.2 Create volume](#22-create-volume)
      * [2.3 Start mysql server service](#23-start-mysql-server-service)
      * [2.4 Start mysql client service](#24-start-mysql-client-service)
      * [2.5 Mysql server resilient test](#25-mysql-server-resilient-test)
      * [2.6 Destroy env](#26-destroy-env)`
   * [3. Highlights](#3-highlights)
   * [4. More resources](#4-more-resources)

# 1. Requirements
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
```
1. Use yaml to start one mysql server service with 1 instance.
2. Use yaml to start one mysql client service with 2 instances.
3. Verify mysql server resilience.
   Delete the instance, confirm another one will be started with no data loss.
```

# 2. Procedures

To setup mysql service, here we use mysql image in [docker hub](https://hub.docker.com/_/mysql/).

## 2.1 Start env
- Start vm
```
# start a VM to host our deployment
minikube start
```

## 2.2 Create volume
```
kubectl create -f ./volume-mysql-server.yml
```

## 2.3 Start mysql server service

- Start mysql server service
```
# Docker: https://hub.docker.com/_/mysql/
kubectl create -f ./rc-mysql-server.yml

# Check instance status
kubectl get pod

# Start service
kubectl create -f ./service-mysql-server.yml

# list service
kubectl get services
```

## 2.4 Start mysql client service
```
kubectl create -f ./rc-mysql-client.yml

# Start service
kubectl create -f ./service-mysql-client.yml

# Get status
kubectl get pod
kubectl get services
kubectl get deployment
```

- Check Web UI
```
minikube dashboard
```

- Open mysql client to access the mysql server

TODO

## 2.5 Mysql server resilient test
- If one instance is down, another will be started automatcially.
TODO

## 2.6 Destroy env
```
minikube delete
```

# 3. Highlights
- Q:

# 4. More resources
- minikube: https://kubernetes.io/docs/getting-started-guides/minikube/
- k8s local solutions: https://kubernetes.io/docs/setup/pick-right-solution/#local-machine-solutions

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
