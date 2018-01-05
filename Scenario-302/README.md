<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

Table of Contents
=================

   * [Requirements](#requirements)
   * [Background &amp; Highlights](#background--highlights)
   * [Procedures](#procedures)
      * [Start minikube env](#start-minikube-env)
      * [Install and run helm](#install-and-run-helm)
      * [Verify Deployment](#verify-deployment)
      * [Clean up](#clean-up)
   * [More resources](#more-resources)

# Requirements
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

```
1. Deploy a single instance wordpress service with helm
2. Enforce daily db backup
3. Scale frontend to 2 instance
```

# Background & Highlights
- Here we use minikube to host our k8s env. Thus we set the service type to NodePort, instead of loadbalancer

# Procedures

## Start minikube env

```
minikube start
```

## Install and run helm

https://github.com/kubernetes/charts/tree/master/stable/wordpress

https://deliciousbrains.com/running-wordpress-kubernetes-cluster

- Start Helm
```
cd challenges-kubernetes/Scenario-302/
helm init
helm repo update
```

- Create volume

Create folder to hold the data
```
minikube ssh

sudo mkdir -p /data
sudo chmod 777 /data
exit
```

Create pv with [pv.yaml](pv.yaml)
```
kubectl apply -f ./pv.yaml
```

- Run helm Deployment

[values.yaml](values.yaml)
```
helm install --name my-wordpress -f values.yaml stable/wordpress
```

## Verify Deployment

```
helm status my-wordpress
```

```
export mysqlRootPassword="secretpassword"
kubectl run -i --tty --rm mysql-client  --image=mysql --restart=Never -- mysql -hmy-wordpress-mysql -uroot -p${mysqlRootPassword}
show databases;

Press Ctrl+D to exit

## ,----------- Example
## | macs-MBP:~ mac$ kubectl run -i --tty --rm mysql-client  --image=mysql --restart=Never -- mysql -hmy-wordpress-mysql -uroot -psecretpassword
## | If you don't see a command prompt, try pressing enter.
## | 
## | mysql> show databases;
## | +--------------------+
## | | Database           |
## | +--------------------+
## | | information_schema |
## | | my-database        |
## | | mysql              |
## | | performance_schema |
## | | sys                |
## | +--------------------+
## | 5 rows in set (0.00 sec)
## `-----------
```

## Clean up

```
helm delete --purge my-wordpress
kubectl delete pod my-wordpress-mysql
minikube delete
```

# More resources

```
https://github.com/kubernetes/charts/tree/master/stable/wordpress
https://github.com/bitnami/bitnami-docker-wordpress
https://deliciousbrains.com/running-wordpress-kubernetes-cluster
https://github.com/kubernetes/helm
```
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
