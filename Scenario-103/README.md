<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

Table of Contents
=================

   * [Requirements](#requirements)
   * [Background &amp; Highlights](#background--highlights)
   * [Procedure](#procedure)
      * [Deployment](#deployment)
      * [Verify Deployment](#verify-deployment)
      * [Cleanup](#cleanup)
   * [Highlights](#highlights)
   * [More resources](#more-resources)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
# Requirements

Scenario-103: 1-Node K8S Deployment III
- Objective: Advanced k8s deployment for one single db service
- Requirements:
```
1. Suppose your k8s/minikube have multiple cluster, how you can segrate them? (Hint: namespace)
2. When we initialize mysql via yaml, avoid store mysql root password in plain text. (Hint: secrets)
3. Make sure we can create no more than 1 pods for DB server. (Hint: ResourceQuota)
```

See [kubernetes.yaml](kubernetes.yaml)

# Background & Highlights

- What is StatefulSet? Why we need it?
- ResourceQuota can apply to current namespace.

# Procedure
## Deployment

To setup mysql service, here we use mysql image in [docker hub](https://hub.docker.com/_/mysql/).

- Start vm
```
# start a VM to host our deployment
minikube start
```

Here we have created a namespace of k8s-1node-test
```
# https://kubernetes.io/docs/tasks/administer-cluster/namespaces-walkthrough/
kubectl create namespace k8s-1node-test
```

Specify mysql root password via k8s secrets, instead of storing the plain text password in yaml directly.
```
kubectl --namespace k8s-1node-test create secret generic mysecret \
        --from-literal=mysql_root_password='my-secret-pw'

kubectl --namespace k8s-1node-test get secrets
kubectl --namespace k8s-1node-test describe secret mysecret

# ,----------- Example
# | macs-MacBook-Pro:Scenario-103 mac$ kubectl --namespace k8s-1node-test describe secret mysecret
# | Name:         mysecret
# | Namespace:    k8s-1node-test
# | Labels:       <none>
# | Annotations:  <none>
# | 
# | Type:  Opaque
# | 
# | Data
# | ====
# | mysql_root_password:  12 bytes
# `-----------
```

```
# Create resourcequota
kubectl --namespace k8s-1node-test create -f ./resourcequota.yaml
kubectl --namespace k8s-1node-test --namespace=k8s-1node-test get resourcequota
```

```
# Create k8s volume, deployment and service
kubectl --namespace k8s-1node-test create -f ./kubernetes.yaml --validate=false
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
kubectl --namespace k8s-1node-test get deployment

# list service
kubectl --namespace k8s-1node-test get services

# List ResourceQuota
kubectl --namespace k8s-1node-test --namespace=k8s-1node-test get resourcequota

# list pods
kubectl --namespace k8s-1node-test get pods

# ,----------- Example
# | macs-MacBook-Pro:Scenario-103 mac$ kubectl --namespace k8s-1node-test get pods
# | NAME                                   READY     STATUS    RESTARTS   AGE
# | dbclient-deployment-69844df475-nwkvg   1/1       Running   0          3m
# | dbclient-deployment-69844df475-vp2g2   1/1       Running   0          3m
# | dbserver-deployment-6d9bdbfbf4-9x7nv   1/1       Running   0          3m
# `-----------
```
- Run functional test

Open mysql client to access the mysql server

Use phpmyadmin, create a database and a table 

Find endpoint of phpmyadmin and dbserver
```
minikube service list

# ,----------- Example
# | macs-MacBook-Pro:Scenario-103 mac$ minikube service list
# | |----------------|----------------------|-----------------------------|
# | |   NAMESPACE    |         NAME         |             URL             |
# | |----------------|----------------------|-----------------------------|
# | | default        | kubernetes           | No node port                |
# | | k8s-1node-test | my-dbclient-service  | http://192.168.99.103:32452 |
# | | k8s-1node-test | my-dbserver-service  | http://192.168.99.103:31049 |
# | | kube-system    | heapster             | No node port                |
# | | kube-system    | kube-dns             | No node port                |
# `-----------
```

TODO: remove http, add screenshot

-  Mysql server resilient test
- If one instance is down, another will be started automatcially.

TODO

From Web UI, delete the mysql server Pod.

We should see ReplicationController will start a new one.

Confirm the database and table still persist, which were created in last step.

## Cleanup

- Delete k8s resources
```
kubectl --namespace k8s-1node-test delete -f ./kubernetes.yaml
kubectl --namespace k8s-1node-test delete -f ./resourcequota.yaml
```

- Delete namespace
```
kubectl delete namespace k8s-1node-test
```

- Destroy env
```
minikube delete
```

# Highlights
- Q: How does the volume process work?

- Q: How PersistentVolumeClaim know use which PersistentVolume?

# More resources
- minikube: https://kubernetes.io/docs/getting-started-guides/minikube/
- k8s local solutions: https://kubernetes.io/docs/setup/pick-right-solution/#local-machine-solutions
- k8s volume: https://blog.couchbase.com/stateful-containers-kubernetes-amazon-ebs/

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
