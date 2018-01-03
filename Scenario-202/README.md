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

Objective: Improve service availability by choosing service type wisely.
```
1. Deploy 3 nodes k8s. One controller, others as workers
2. Create a nginx service with 6 instances.
3. Make sure nginx requests will be balanced across 6 instances.
   (Hint: ClusterIP + Ingress, or External Loadbalancer)
```

# Background & Highlights

```
1. For public cloud, we can choose service type as External Loadbalancer.
   In AWS, it will create a ELB/ALB. And redirect the requests correctly.
   Similar things for Azure, GCE.

2. For on-premise env, we can create service with ClusterIP.
   Then we will need to create Ingress resource for routing rules

3. For on-premise env, we can create service with NodePort.
   Then we will need a reverse proxy to balance the requests.
   Example: https://blog.oestrich.org/2016/01/nodeport-kubernetes-load-balancer/
```

Here we will use method #2: Local vagrant k8s cluster + ClusterIP + Ingress

- Questions:
```
1. In my on-premise env, I have specified service type to LoadBalancer.
   But why EXTERNAL-IP remains in the pending state?

2. How Does NodePort work behind the scene?

3. How I configure Ingress?
```

- Publishing services - service types
```
https://kubernetes.io/docs/concepts/services-networking/service/

For some parts of your application (e.g. frontends) you may want to
expose a Service onto an external (outside of your cluster) IP
address.

Kubernetes ServiceTypes allow you to specify what kind of service you want. The default is ClusterIP.

Type values and their behaviors are:

- ClusterIP: Exposes the service on a cluster-internal IP. Choosing
  this value makes the service only reachable from within the
  cluster. This is the default ServiceType.

- NodePort: Exposes the service on each Node’s IP at a static port
  (the NodePort). A ClusterIP service, to which the NodePort service
  will route, is automatically created. You’ll be able to contact the
  NodePort service, from outside the cluster, by requesting
  <NodeIP>:<NodePort>.

- LoadBalancer: Exposes the service externally using a cloud
  provider’s load balancer. NodePort and ClusterIP services, to which
  the external load balancer will route, are automatically created.

- ExternalName: Maps the service to the contents of the externalName
  field (e.g. foo.bar.example.com), by returning a CNAME record with
  its value. No proxying of any kind is set up. This requires version
  1.7 or higher of kube-dns.

```

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
kubectl create namespace nginx-6node-test
```

- Run Deployment
```
kubectl --namespace nginx-6node-test create -f ./kubernetes.yaml
```
See [kubernetes.yaml](kubernetes.yaml)

## Verify Deployment
```
# List nodes
kubectl --namespace nginx-6node-test get nodes

# List services
kubectl --namespace nginx-6node-test get services

# List pods
kubectl --namespace nginx-6node-test get pods
```

- List all pods with node info attached.
```
for pod in $(kubectl --namespace nginx-6node-test get pods -o jsonpath="{.items[*].metadata.name}"); do
    node_info=$(kubectl --namespace nginx-6node-test describe pod $pod | grep "Node:")
    echo "Pod: $pod, $node_info"
done

# We shall see 6 nginx podes across two k8s worker nodes. (k8s2 and k8s3)
# Sample output
## Pod: nginx-deployment-668845bd79-47d6w, Node:           k8s2/172.42.42.2
## Pod: nginx-deployment-668845bd79-bf2kh, Node:           k8s3/172.42.42.3
## Pod: nginx-deployment-668845bd79-k62q4, Node:           k8s3/172.42.42.3
## Pod: nginx-deployment-668845bd79-vz58b, Node:           k8s3/172.42.42.3
## Pod: nginx-deployment-668845bd79-xb6mm, Node:           k8s2/172.42.42.2
## Pod: nginx-deployment-668845bd79-zqqwc, Node:           k8s2/172.42.42.2
```

- Clean up: nginx deployment
```
kubectl --namespace nginx-6node-test delete -f ./kubernetes.yaml
```

- Clean up: virtualbox env
```
cd challenges-kubernetes/Scenario-202/k8s-playground
vagrant destroy
```

# More resources

```
https://kubernetes.io/docs/tasks/access-application-cluster/load-balance-access-application-cluster/
Provide Load-Balanced Access to an Application in a Cluster

https://github.com/davidkbainbridge/k8s-playground
Simple VM based Kubernetes cluster setup
```
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
