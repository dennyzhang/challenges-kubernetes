Table of Contents
=================
<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

   * [1. Requirements](#1-requirements)
   * [2. Procedures](#2-procedures)
      * [2.1 Start env](#21-start-env)
      * [2.2 Resilient test](#22-resilient-test)
      * [2.3 Destroy env](#23-destroy-env)
   * [3. Highlights](#3-highlights)
   * [4. More resources](#4-more-resources)

# 1. Requirements
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
```
1. Start one mysql service in your laptop.
   Use docker volume to persist the data

2. Make mysql service is resilient.
   If one instance is down, another will be started automatcially.
```

# 2. Procedures

To setup mysql service, here we use [mysql image](https://hub.docker.com/_/mysql/) from docker hub

## 2.1 Start env
```
# start a VM to host our deployment
minikube start

# TODO: use docker volume
# TODO: configure env
# Docker: https://hub.docker.com/_/mysql/
kubectl run hello-mysql-server --image=mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw --port=3306

# Expose service
kubectl expose deployment hello-mysql-server --type=NodePort

# Docker: https://hub.docker.com/_/adminer/
# TODO: link db
kubectl run hello-mysql-client --image=adminer --port=8080
# Expose service
kubectl expose deployment hello-mysql-client --type=NodePort

# Check instance status
kubectl get pod

# list service
kubectl service list
```

- Access mysql service to confirm the deployment

TODO

## 2.2 Resilient test
- If one instance is down, another will be started automatcially.
TODO

## 2.3 Destroy env
```
minikube delete
```

# 3. Highlights
- Q:

# 4. More resources
- minikube: https://kubernetes.io/docs/getting-started-guides/minikube/
- k8s local solutions: https://kubernetes.io/docs/setup/pick-right-solution/#local-machine-solutions

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
