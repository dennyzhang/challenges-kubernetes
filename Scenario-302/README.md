<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

Table of Contents
=================

   * [Requirements](#requirements)
   * [Background &amp; Highlights](#background--highlights)
   * [Procedures](#procedures)
      * [Start minikube env](#start-minikube-env)
      * [Install and run helm](#install-and-run-helm)
      * [Verify Deployment](#verify-deployment)
      * [Clean up](#clean-up)
   * [More resources](#more-resources)

# Requirements
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

```
1. Deploy a single instance wordpress service with helm
2. Customize the deployment
```

# Background & Highlights
- Helm is the Kubernetes Package Manager. Community provides well-organized deployment solutions for typical services
- Our focus is helm, thus we use mninikube for this study

# Procedures

## Start minikube env

```
minikube start
```

## Install and run helm

https://github.com/kubernetes/helm

- Start Helm
```
cd challenges-kubernetes/Scenario-301/
helm init
helm repo update
```

- Create volume for mysql

Create folder to hold the data
```
minikube ssh

sudo mkdir -p /data
sudo chmod 777 /data
exit
```

Create pv
```
cat > /tmp/pv.yaml <<EOF
kind: PersistentVolume
apiVersion: v1
metadata:
  name: mydata
  labels:
    type: local
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/data/mydata"
EOF

kubectl apply -f /tmp/pv.yaml
```

- Run helm Deployment
```
export mysqlRootPassword="secretpassword"
helm install --name mysql-release \
  --set mysqlRootPassword=${mysqlRootPassword},mysqlUser=my-user,mysqlPassword=my-password,mysqlDatabase=my-database \
    stable/mysql
```

## Verify Deployment

```
export mysqlRootPassword="secretpassword"
kubectl run -i --tty --rm mysql-client  --image=mysql --restart=Never -- mysql -hmysql-release-mysql -uroot -p${mysqlRootPassword}
show databases;

Press Ctrl+D to exit

## ,----------- Example
## | macs-MBP:~ mac$ kubectl run -i --tty --rm mysql-client  --image=mysql --restart=Never -- mysql -hmysql-release-mysql -uroot -psecretpassword
## | If you don't see a command prompt, try pressing enter.
## | 
## | mysql> show databases;
## | +--------------------+
## | | Database           |
## | +--------------------+
## | | information_schema |
## | | my-database        |
## | | mysql              |
## | | performance_schema |
## | | sys                |
## | +--------------------+
## | 5 rows in set (0.00 sec)
## `-----------
```

## Clean up

```
helm delete --purge mysql-release
kubectl delete pod mysql-release-mysql
minikube delete
```

# More resources

```
https://github.com/kubernetes/helm
```
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
