Table of Contents
=================
<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

   * [1. Requirements](#1-requirements)
   * [2. Procedures](#2-procedures)
      * [2.1 Install virtualbox and minikube](#21-install-virtualbox-and-minikube)
      * [2.2 Start env](#22-start-env)
      * [2.3 Check k8s dashboard](#23-check-k8s-dashboard)
      * [2.4 Scale the instance](#24-scale-the-instance)
      * [2.5 Verify deployment](#25-verify-deployment)
      * [2.6 Destroy env](#26-destroy-env)
   * [3. Highlights](#3-highlights)
   * [4. More resources](#4-more-resources)

# 1. Requirements
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

```
1. Start one node of k8s in your laptop. Mac or Linux
2. Start a nginx webserver with one instance
3. Scale nginx service into 2 instances.
4. Test nginx URL, and confirm the hits from nginx log of two instances
```

# 2. Procedures

For single node deployment, we have [multiple choices](https://kubernetes.io/docs/setup/pick-right-solution/#local-machine-solutions). Here we use [minikube](https://kubernetes.io/docs/getting-started-guides/minikube/).

## 2.1 Install virtualbox and minikube
```
which minikube
which kubectl
```

## 2.2 Start env
```
# start a VM to host our deployment
minikube start

# Here we use nginx docker image from docker hub. Nginx listen on port 80
# https://hub.docker.com/_/nginx/
kubectl run hello-nginx --image=nginx --port=80

# Expose service
kubectl expose deployment hello-nginx --type=NodePort

# Check instance status
kubectl get pod

# list service
minikube list service
```

## 2.3 Check k8s dashboard
```
minikube dashboard
```

## 2.4 Scale the instance
```
kubectl scale --replicas=2 deployment/hello-nginx
```

## 2.5 Verify deployment
```
# Get endpoint url of nginx service
kubectl list service

# Send requests
for((i=0; i< 10; i++)); do { curl http://$service_url;}; done
```

Go to minikube dashboard -> Pods -> choose one pod -> LOGS

## 2.6 Destroy env
```
minikube delete
```

# 3. Highlights
- Q: How to use your own docker image?

- Q: What does "kubectl expose deployment .." do behind the scene?

# 4. More resources
- minikube: https://kubernetes.io/docs/getting-started-guides/minikube/
- k8s local solutions: https://kubernetes.io/docs/setup/pick-right-solution/#local-machine-solutions

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
