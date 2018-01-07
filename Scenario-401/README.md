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
1. Deploy Jenkins service by helm.
2. Make sure JENKINS_HOME directory persist
3. Install slack and git Jenkins plugins during helm install
4. Enable Jenkins slave agents during helm install
5. Start 2 Jenkins masters.
```

# Background & Highlights
- JENKINS master HA
- We need to create volume

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
kubectl get pvc

## ,-----------
## | macs-MBP:Scenario-401 mac$ kubectl get pv
## | NAME        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM     STORAGECLASS   REASON    AGE
## | jenkins-home     20Gi        RWO            Retain           Bound      default/jenkins-home             standard                 2s
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
kubectl logs ${jenkins_master_pod_name} -c copy-default-config
```

- Check saved JENKINS_HOME directory
```
minikube ssh
ls -lth /data/jenkins-home

## ,----------- Example
## | $ ls -lth /data/jenkins-home
## | total 80K
## | drwxr-xr-x  2 root root 4.0K Jan  7 14:22 updates
## | drwxr-xr-x  2 root root 4.0K Jan  7 14:22 workflow-libs
## | -rw-r--r--  1 root root 4.0K Jan  7 14:22 config.xml
## | drwxr-xr-x  3 root root 4.0K Jan  7 14:22 logs
## | -rw-r--r--  1 root root  907 Jan  7 14:22 nodeMonitors.xml
## | drwxr-xr-x  2 root root 4.0K Jan  7 14:22 userContent
## | drwxr-xr-x  2 root root 4.0K Jan  7 14:22 nodes
## | -rw-r--r--  1 root root  370 Jan  7 14:22 hudson.plugins.git.GitTool.xml
## | -rw-------  1 root root 1.7K Jan  7 14:22 identity.key.enc
## | drwxr-xr-x  4 root root 4.0K Jan  7 14:22 secrets
## | -rw-r--r--  1 root root  156 Jan  7 14:22 hudson.model.UpdateCenter.xml
## | drwxr-xr-x 54 root root  12K Jan  7 14:22 plugins
## | drwxr-xr-x  2 root root 4.0K Jan  7 14:22 jobs
## | -rw-r--r--  1 root root    0 Jan  7 14:22 secret.key.not-so-secret
## | -rw-r--r--  1 root root   64 Jan  7 14:22 secret.key
## | drwxr-xr-x 10 root root 4.0K Jan  7 14:22 war
## | -rw-r--r--  1 root root 2.5K Jan  7 14:22 copy_reference_file.log
## | drwxr-xr-x  2 root root 4.0K Jan  7 14:22 init.groovy.d
## | -rw-r--r--  1 root root   91 Jan  7 14:21 plugins.txt
## `-----------
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
- Enable Jenkins agent

- Install more Jenkins plugins

- Scale jenkins agent

## Clean up

```
helm delete --purge my-jenkins
kubectl delete -f ./pv.yaml
minikube delete
```

# More resources

```
https://github.com/kubernetes/charts/tree/master/stable/jenkins
https://github.com/kubernetes/helm
```
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
