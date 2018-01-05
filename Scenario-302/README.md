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
2. Scale frontend to 2 instance
3. Enforce daily volume backup
4. Enforce daily db backup
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

Workaround for minikube bug: https://github.com/kubernetes/minikube/issues/2256

```
minikube ssh
ls -lth /tmp/ | grep hostpath
sudo chmod 777 /tmp/hostpath*
ls -lth /tmp/ | grep hostpath
```

Create folder to hold the data
```
minikube ssh

sudo mkdir -p /data/mariadb /data/wordpress
sudo chmod 777 /data/mariadb /data/wordpress
ls -lth /data

exit

## ,----------- Example
## | $ ls -lth /data
## | total 8.0K
## | drwxrwxrwx 2 root root 4.0K Jan  5 22:40 wordpress
## | drwxrwxrwx 2 root root 4.0K Jan  5 22:38 mariadb
## `-----------
```

Create pv with [pv.yaml](pv.yaml)
```
kubectl apply -f ./pv.yaml
kubectl get pv
```

- Run helm Deployment

[values.yaml](values.yaml)
```
helm install --name my-wordpress -f values.yaml stable/wordpress
```

## Verify Deployment

- Check status
```
helm status my-wordpress
kubectl get pod
```

- Initialize wordpress
```
NOTES:
1. Get the WordPress URL:

  Or running:

  export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services my-wordpress-wordpress)
  export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")
  echo http://$NODE_IP:$NODE_PORT/admin

2. Login with the following credentials to see your blog

  echo Username: admin
  echo Password: $(kubectl get secret --namespace default my-wordpress-wordpress -o jsonpath="{.data.wordpress-password}" | base64 --decode)
```

## Clean up

```
helm delete --purge my-wordpress
kubectl delete -f ./pv.yaml
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
