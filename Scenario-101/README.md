Table of Contents
=================
<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

   * [1. Requirements](#1-requirements)
   * [2. Procedures](#2-procedures)
      * [2.1 Install virtualbox and minikube](#21-install-virtualbox-and-minikube)
      * [2.2 Start env](#22-start-env)
      * [2.3 Check Status](#23-check-status)
      * [2.4 Destroy env](#24-destroy-env)
   * [3. Highlights](#3-highlights)
   * [4. More resources](#4-more-resources)

# 1. Requirements
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

```
1. Start one node of k8s in your laptop. Mac or Linux
2. Start a nginx webserver with one instance
3. Scale nginx service into 2 instances.
4. Get familiar with k8s dashboard. Find pods from GUI, check nginx log.
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

# Create k8s deployment and export service
kubectl create -f ./kubernetes.yaml
```

## 2.3 Check Status
- List k8s resources
```
# list deployments
kubectl get deployment

# list service
kubectl get services

# list pods
kubectl get pods
```

- Check the first pod
```
# Get all pods
kubectl get pods -l app="nginx"

# Get the first pod
POD_NAME=$(kubectl get pods -l app="nginx" -o jsonpath="{.items[0].metadata.name}")
echo "POD_NAME: $POD_NAME"

# Login to the first pod
kubectl exec -ti $POD_NAME hostname

# Check log of the first pd
kubectl logs -f $POD_NAME
```

- Check k8s web UI Dashboard
```
minikube dashboard
```

- Run functional test
```
# Get endpoint url of nginx service
kubectl get services

# Send requests
server_url="192.168.99.102:30000"
for((i=0; i< 10; i++)); do { curl http://$service_url;}; done
```

## 2.4 Destroy env
- Delete k8s resources
```
kubectl delete -f ./kubernetes.yaml
```

- Remove VM
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
