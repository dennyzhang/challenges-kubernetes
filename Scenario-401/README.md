<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

Table of Contents
=================

   * [Requirements](#requirements)
   * [Background &amp; Highlights](#background--highlights)
   * [Procedures](#procedures)
      * [Start minikube env](#start-minikube-env)
      * [Install and run helm](#install-and-run-helm)
      * [Initialize Jenkins](#initialize-jenkins)
      * [Advanced Setup](#advanced-setup)
      * [Clean up](#clean-up)
   * [More resources](#more-resources)

# Requirements
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

Scenario-401: Deploy a stateful service I
```
1. Deploy 3 nodes k8s. One controller, others as workers
2. Deploy Jenkins service by helm. 1 Jenkins master 2 agent
```

# Background & Highlights
- 

# Procedures

## Start k8s cluster
TODO

## Install and run helm

https://github.com/kubernetes/charts/tree/master/stable/jenkins

- Start Helm
```
cd challenges-kubernetes/Scenario-401/
helm init
helm repo update
helm list
```

- Create volume

TODO

Create folder to hold the data
```
minikube ssh

sudo mkdir -p /data/jenkins-home
sudo chmod 777 -R /data/jenkins-home
ls -lth /data

exit

## ,----------- Example
## | $ ls -lth /data
## | total 8.0K
## | drwxrwxrwx 2 root root 4.0K Jan  5 22:38 jenkins_home
## `-----------
```

Create pv with [pv.yaml](pv.yaml)
```
kubectl apply -f ./pv.yaml
kubectl get pv

## ,-----------
## | macs-MBP:Scenario-401 mac$ kubectl get pv
## | NAME        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM     STORAGECLASS   REASON    AGE
## | jenkins-home     5Gi        RWO            Retain           Bound      default/jenkins-home             standard                 2s
## `-----------
```

- Run helm Deployment

[values.yaml](values.yaml)
```
helm install --name my-jenkins -f values.yaml stable/jenkins
```

## Initialize Jenkins

- Check status
```
helm status my-jenkins
kubectl get pod

# Get lof of mariadb initContainer
kubectl log ${mariadb_pod_name} -c copy-custom-config
```

- Initialize jenkins
```
NOTES:
1. Get your 'admin' user password by running:
  printf $(kubectl get secret --namespace default my-jenkins-jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo
2. Get the Jenkins URL to visit by running these commands in the same shell:
  export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services my-jenkins-jenkins)
  export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")
  echo http://$NODE_IP:$NODE_PORT/login

3. Login with the password from step 1 and the username: admin

For more information on running Jenkins on Kubernetes, visit:
https://cloud.google.com/solutions/jenkins-on-container-engine
```

## Advanced Setup
- Scale jenkins frontend
```
kubectl get deployments

## ,----------- Example
## | macs-MacBook-Pro:Scenario-401 mac$ kubectl get deployments
## | NAME                     DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
## | my-jenkins-mariadb     1         1         1            1           18m
## | my-jenkins-jenkins   1         1         1            1           18m
## `-----------

kubectl scale --replicas=2 deployment my-jenkins-jenkins

kubectl get deployments
kubectl get pod
```

- Verify functionality after deployment
```
export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services my-jenkins-jenkins)
export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")
curl -I http://$NODE_IP:$NODE_PORT/
```

- Delete one pod and verify service is fine
```
kubectl get pod

## ,----------- Example
## | macs-MacBook-Pro:Scenario-401 mac$ kubectl get pod
## | NAME                                     READY     STATUS    RESTARTS   AGE
## | my-jenkins-mariadb-8647d4cff7-cvm9k    1/1       Running   0          21m
## | my-jenkins-jenkins-df987548d-t6fxg   1/1       Running   0          21m
## | my-jenkins-jenkins-df987548d-xc8tf   1/1       Running   0          2m
## `-----------

# Choose one pod and delete it
kubectl delete pod my-jenkins-jenkins-df987548d-t6fxg

# Check again, we will see another jenkins frontend pod up and running.

## ,----------- Example
## | macs-MacBook-Pro:Scenario-401 mac$ kubectl get pod
## | NAME                                     READY     STATUS        RESTARTS   AGE
## | my-jenkins-mariadb-8647d4cff7-cvm9k    1/1       Running       0          23m
## | my-jenkins-jenkins-df987548d-7798d   0/1       Pending       0          26s
## | my-jenkins-jenkins-df987548d-t6fxg   0/1       Terminating   0          23m
## | my-jenkins-jenkins-df987548d-xc8tf   1/1       Running       0          3m
## `-----------
```

## Enforce Backup
- Find DB password from volume
```
minikube ssh
grep -i DB_PASSWORD /data/jenkins/jenkins/wp-config.php

## ,----------- Example
## | $ grep -i DB_PASSWORD /data/jenkins/jenkins/wp-config.php
## | define('DB_PASSWORD', 'SUuQeB5pPX');
## `-----------

export DB_PASSWORD=$(grep -i DB_PASSWORD /data/jenkins/jenkins/wp-config.php | awk -F"'" '{print $4}')
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

kubectl get cronjob my-jenkins-mariadb-backup
kubectl get cronjob my-jenkins-mariadb-backup --watch

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
helm delete --purge my-jenkins
kubectl delete -f ./cronjob.yaml
kubectl delete -f ./backup-storage.yaml
kubectl delete -f ./pv.yaml
minikube delete
```

# More resources

```
https://github.com/kubernetes/charts/tree/master/stable/jenkins
https://github.com/kubernetes/helm
```
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
