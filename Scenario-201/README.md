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
2. Create a nginx service with 6 instances. Confirmed they are distributed.
3. Visit nginx service by loadbalancer. (Hint: Ingress)
```

# Background & Highlights

Two different categories. They're different. And each would be big and complicated.
1. Setup a k8s cluster itself. Improve k8s availability and reliablity
2. Deploy clustered services in k8s cluster. Improve services' availability and reliablity

**Our focus is more about category #2.**

For Category #1, I have recommendations for two GitHub Repos.
```
Start 3 nodes k8s cluster by vagrant. 1 controller 2 workers
https://github.com/davidkbainbridge/k8s-playground

Start 6 nodes k8s cluster in Google Cloud Platform. 3 controller 3 workers
https://github.com/kelseyhightower/kubernetes-the-hard-way
```

# Procedures

## Start k8s Cluster
- Install virtualbox and vagrant

Here we use davidkbainbridge's repo of [k8s-playground](https://github.com/davidkbainbridge/k8s-playground)

It will setup 3 nodes k8s cluster in your local virtualbox.

- Start k8s cluster by vagrant
```
cd challenges-kubernetes/Scenario-201/k8s-playground
vagrant up -d
```

- Verify k8s cluster env

TODO

## Deploy Service

- Create namespace
```
kubectl create namespace nginx-6node-test
```

- Run Deployment
```
kubectl --namespace nginx-6node-test create -f ./kubernetes.yaml
```

## Verify Deployment
```
```

TODO

# More resources

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
