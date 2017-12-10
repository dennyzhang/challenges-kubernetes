<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

Table of Contents
=================

   * [Requirements](#requirements)
   * [Background &amp; Highlights](#background--highlights)
   * [Procedures](#procedures)
      * [Start k8s Cluster](#start-k8s-cluster)
      * [Deploy Service](#deploy-service)
      * [Verify Deployment](#verify-deployment)
   * [More resources](#more-resources)

# Requirements
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

```
1. Deploy 3 nodes k8s. One controller, others as worker
2. Create an elasticsearch service with 3 instances.
   2 as master, 4 as data.
3. Create a nightly job to backup elasticsearch cluster. (Hint: Cron Jobs)
```
<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/challenges-kubernetes/master/images/k8s_concept3.png"/> </a>

# Background & Highlights

- Here we assume you know how to use and deployment elasticsearch cluster

# Procedures

## Start k8s Cluster
- Install virtualbox and vagrant

```
Here we use k8s-playground: https://github.com/davidkbainbridge/k8s-playground

It will setup 3 nodes k8s cluster in your local virtualbox.
```

- Start k8s cluster by vagrant
```
cd challenges-kubernetes/Scenario-202/k8s-playground
vagrant up -d
```

- Verify k8s cluster env
```
cd challenges-kubernetes/Scenario-202/k8s-playground
vagrant ssh k8s1
kubectl -n kube-system get po -o wide

# List nodes
kubectl get nodes

# List built-in services
kubectl get services
```

- Starting Networking
```
cd challenges-kubernetes/Scenario-202/k8s-playground
vagrant ssh k8s1

ubuntu@k8s1:~$ start-weave
serviceaccount "weave-net" created
clusterrole "weave-net" created
clusterrolebinding "weave-net" created
role "weave-net-kube-peer" created
rolebinding "weave-net-kube-peer" created
daemonset "weave-net" created
```

TODO

## Deploy Service

- Create namespace
```
kubectl create namespace es-6node-test
```

- Run Deployment
```
kubectl --namespace es-6node-test create -f ./service-account.yaml
kubectl --namespace es-6node-test create -f ./es-svc.yaml
kubectl --namespace es-6node-test create -f ./kubernetes.yaml
```
See [kubernetes.yaml](kubernetes.yaml)

## Verify Deployment
```
# List services
kubectl --namespace es-6node-test get services

# List deployment
kubectl --namespace es-6node-test get deployment

# List pods
kubectl --namespace es-6node-test get pods

# List nodes
kubectl --namespace es-6node-test get nodes
```

- List all pods with node info attached.
```
for pod in $(kubectl --namespace es-6node-test get pods -o jsonpath="{.items[*].metadata.name}"); do
    node_info=$(kubectl --namespace es-6node-test describe pod $pod | grep "Node:")
    echo "Pod: $pod, $node_info"
done

# Sample output
Pod: elasticsearch-data-deployment-6cf4d97bbb-895tp, Node:           k8s2/172.42.42.2
Pod: elasticsearch-data-deployment-6cf4d97bbb-nqxnw, Node:           k8s3/172.42.42.3
Pod: elasticsearch-master-deployment-bbfd44b76-8zldd, Node:           k8s3/172.42.42.3
```

- Login to one pod and check service
```
POD_NAME=$(kubectl --namespace es-6node-test get pods -l app="elasticsearch" -o jsonpath="{.items[0].metadata.name}")
# Login to the first pod
kubectl --namespace es-6node-test exec -ti $POD_NAME hostname

kubectl --namespace es-6node-test exec -it $POD_NAME sh

# Install curl
apk add --update curl

# List es nodes in the cluster
curl localhost:9200/_cat/nodes?v
```

TODO: list all es nodes

TODO: check es data

- Clean up: es deployment
```
kubectl --namespace es-6node-test delete -f ./kubernetes.yaml
kubectl --namespace es-6node-test delete -f ./es-svc.yaml
kubectl --namespace es-6node-test delete -f ./service-account.yaml
kubectl delete namespace es-6node-test
```

- Clean up: virtualbox env
```
cd challenges-kubernetes/Scenario-202/k8s-playground
vagrant destroy
```

# More resources

```
https://github.com/kubernetes/examples/blob/master/staging/elasticsearch/README.md
Elasticsearch for Kubernetes

https://github.com/kubernetes/kubernetes/tree/master/examples/elasticsearch
elasticsearch kubernetes

https://github.com/davidkbainbridge/k8s-playground
Simple VM based Kubernetes cluster setup

https://kubernetes.io/docs/reference/kubectl/cheatsheet/
kubectl Cheat Sheet
```
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
