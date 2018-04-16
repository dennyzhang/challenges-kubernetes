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

## Initialize Wordpress

- Check status
```
helm status my-wordpress
kubectl get pod

# Get lof of mariadb initContainer
kubectl logs ${mariadb_pod_name} -c copy-custom-config
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

3. Try the blog in web browse

  open http://$NODE_IP:$NODE_PORT/admin
```

## Advanced Setup
- Scale wordpress frontend
```
kubectl get deployments

## ,----------- Example
## | macs-MacBook-Pro:Scenario-304 mac$ kubectl get deployments
## | NAME                     DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
## | my-wordpress-mariadb     1         1         1            1           18m
## | my-wordpress-wordpress   1         1         1            1           18m
## `-----------

kubectl scale --replicas=2 deployment my-wordpress-wordpress

kubectl get deployments
kubectl get pod
```

- Verify functionality after deployment
```
export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services my-wordpress-wordpress)
export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")
curl -I http://$NODE_IP:$NODE_PORT/
```

- Delete one pod and verify service is fine
```
kubectl get pod

## ,----------- Example
## | macs-MacBook-Pro:Scenario-304 mac$ kubectl get pod
## | NAME                                     READY     STATUS    RESTARTS   AGE
## | my-wordpress-mariadb-8647d4cff7-cvm9k    1/1       Running   0          21m
## | my-wordpress-wordpress-df987548d-t6fxg   1/1       Running   0          21m
## | my-wordpress-wordpress-df987548d-xc8tf   1/1       Running   0          2m
## `-----------

# Choose one pod and delete it
kubectl delete pod my-wordpress-wordpress-df987548d-t6fxg

# Check again, we will see another wordpress frontend pod up and running.

## ,----------- Example
## | macs-MacBook-Pro:Scenario-304 mac$ kubectl get pod
## | NAME                                     READY     STATUS        RESTARTS   AGE
## | my-wordpress-mariadb-8647d4cff7-cvm9k    1/1       Running       0          23m
## | my-wordpress-wordpress-df987548d-7798d   0/1       Pending       0          26s
## | my-wordpress-wordpress-df987548d-t6fxg   0/1       Terminating   0          23m
## | my-wordpress-wordpress-df987548d-xc8tf   1/1       Running       0          3m
## `-----------
```

## Enforce Backup
- Find DB password from volume
```
minikube ssh
grep -i DB_PASSWORD /data/wordpress/wordpress/wp-config.php

## ,----------- Example
## | $ grep -i DB_PASSWORD /data/wordpress/wordpress/wp-config.php
## | define('DB_PASSWORD', 'SUuQeB5pPX');
## `-----------

export DB_PASSWORD=$(grep -i DB_PASSWORD /data/wordpress/wordpress/wp-config.php | awk -F"'" '{print $4}')
```

- Inject db password as secret
```
# Get it from the previous step: find DB password from volume
DB_PASSWORD="CHANGETHIS"
echo -n "$DB_PASSWORD" > ./password.txt
kubectl create secret generic db-user-pass --from-file=./password.txt
kubectl describe secret db-user-pass
```

- Create cronjob to run mysql backup
```
kubectl apply -f ./backup-storage.yaml
kubectl get pv
kubectl get pvc

kubectl apply -f ./cronjob.yaml

kubectl get cronjob my-wordpress-mariadb-backup
kubectl get cronjob my-wordpress-mariadb-backup --watch

kubectl get pod | grep backup
```

- Confirm db backup
```
# In our test, we have enabled db backup every minute. Thus we can check the status much faster
# See the schedule line of cronjob.yaml
# In real case, we definitely shouldn't run db backup this often.

minikube ssh
ls -lth /data/mariadb-backup

## ,----------- Example
## | $ ls -lth /data/mariadb-backup
## | total 3.0M
## | -rw-r--r-- 1 root root 600K Jan  6 15:58  db_backup_20180106_155806.sql
## | -rw-r--r-- 1 root root 600K Jan  6 15:57  db_backup_20180106_155706.sql
## `-----------
```
## Clean up

```
helm delete --purge my-wordpress
kubectl delete -f ./cronjob.yaml
kubectl delete -f ./backup-storage.yaml
kubectl delete -f ./pv.yaml
minikube delete
```

# More resources

```
https://github.com/kubernetes/charts/tree/master/stable/wordpress
https://github.com/bitnami/bitnami-docker-wordpress
https://kubernetes.io/docs/tasks/access-application-cluster/connecting-frontend-backend/
https://deliciousbrains.com/running-wordpress-kubernetes-cluster
https://github.com/kubernetes/helm
```
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
