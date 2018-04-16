<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

Table of Contents
=================

   * [Requirements](#requirements)
   * [Background &amp; Highlights](#background--highlights)
   * [Procedures](#procedures)
      * [Start minikube env](#start-minikube-env)
      * [Install and run helm](#install-and-run-helm)
      * [Initialize Wordpress](#initialize-wordpress)
      * [Advanced Setup](#advanced-setup)
      * [Clean up](#clean-up)
   * [More resources](#more-resources)

# Requirements
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

Scenario-304: Use helm To Deploy Service IV
- Objective: Deploy elasticsearch cluster with 5 instances
- Requirements:
```
1. Create an elasticsearch cluster
2. Scale the env to 5 instances
```

# Background & Highlights
- 

# Procedures

## Start k8s cluster

```
minikube start
eval $(minikube docker-env)
```

## Install and run helm

https://github.com/kubernetes/charts/tree/master/stable/wordpress

https://deliciousbrains.com/running-wordpress-kubernetes-cluster

- Start Helm
```
cd challenges-kubernetes/Scenario-304/
helm init
kubectl get pods --namespace kube-system
tiller_name=$(kubectl get pods --namespace kube-system | grep "tiller.*Running" | awk -F" " '{print $1}')
kubectl --namespace kube-system describe pod $tiller_name
helm repo update
# check whether the helm backend(tiller) is up and running
helm list
```

- Run helm Deployment

[values.yaml](values.yaml)
```
helm install --name my-es -f values.yaml incubator/elasticsearch
```

- Verify functionality after deployment
```
helm status my-es
```
## Clean up

```
helm delete --purge my-es
minikube delete
```

# More resources

```
https://github.com/kubernetes/charts/tree/master/incubator/elasticsearch
https://github.com/kubernetes/helm
```
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
