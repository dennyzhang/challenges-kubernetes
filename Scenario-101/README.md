Table of Contents
=================
<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

   * [Requirements](#requirements)
   * [Background &amp; Highlights](#background--highlights)
   * [Procedures](#procedures)
      * [Deployment](#deployment)
      * [Verify Deployment](#verify-deployment)
   * [More resources](#more-resources)

# Requirements
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

```
1. Start one node of k8s in your laptop. Mac or Linux
2. Start a nginx webserver with one instance
3. Scale nginx service into 2 instances.
4. Get familiar with k8s dashboard. Find pods from GUI, check nginx log.
```

See [kubernetes.yaml](kubernetes.yaml)

# Background & Highlights
- Q: How to use your own docker image?

- Q: What does "kubectl expose deployment .." do behind the scene?

# Procedures

For single node deployment, we have [multiple choices](https://kubernetes.io/docs/setup/pick-right-solution/#local-machine-solutions). Here we use [minikube](https://kubernetes.io/docs/getting-started-guides/minikube/).

## Deployment
- Install virtualbox and minikube
```
which minikube
which kubectl
```

- Start env
```
# start a VM to host our deployment
minikube start

# Create k8s deployment and export service
kubectl create -f ./kubernetes.yaml
```
See [kubernetes.yaml](kubernetes.yaml)

## Verify Deployment
- Check k8s web UI Dashboard
```
minikube dashboard
```

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

- Run functional test
```
# Get endpoint url of nginx service
kubectl get services

# Send requests
service_url="$(minikube service my-nginx-service --url)"
for((i=0; i< 5; i++)); do { curl -I "$service_url";}; done
```

Destroy env:
- Delete k8s resources
```
kubectl delete -f ./kubernetes.yaml
```

- Remove VM
```
minikube delete
```

# More resources
- minikube: https://kubernetes.io/docs/getting-started-guides/minikube/
- k8s local solutions: https://kubernetes.io/docs/setup/pick-right-solution/#local-machine-solutions

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
