# challenges-kubernetes

[![Build Status](https://travis-ci.org/DennyZhang/challenges-kubernetes.svg?branch=master)](https://travis-ci.org/DennyZhang/challenges-kubernetes) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

[![LinkedIn](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) <a href="https://www.dennyzhang.com/slack" target="_blank" rel="nofollow"><img src="http://slack.dennyzhang.com/badge.svg" alt="slack"/></a> [![Github](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/github.png)](https://github.com/DennyZhang)

File me [tickets](https://github.com/DennyZhang/challenges-kubernetes/issues) or star [the repo](https://github.com/DennyZhang/challenges-kubernetes).

**Similar Challenges**: https://www.dennyzhang.com/battle

<a href="https://github.com/DennyZhang?tab=followers"><img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/fork_github.png" /></a>

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/challenges-kubernetes/master/images/kubernetes.png"/> </a>

Table of Contents
=================
Challenges Your Kubernetes Skills And Knowledge

   * [Scenarios](#scenarios)
      * [Scenario-101: 1-Node K8S Deployment I](#scenario-101-1-node-k8s-deployment-i)
      * [Scenario-102: 1-Node K8S Deployment II](#scenario-102-1-node-k8s-deployment-ii)
      * [Scenario-103: 1-Node K8S Deployment III](#scenario-103-1-node-k8s-deployment-iii)
      * [Scenario-201: 2-Nodes K8S Deployment I](#scenario-201-2-nodes-k8s-deployment-i)
      * [Scenario-202: 2-Nodes K8S Deployment II](#scenario-202-2-nodes-k8s-deployment-ii)
      * [Scenario-301: 2-Nodes Elasticsearch Deployment I](#scenario-301-2-nodes-elasticsearch-deployment-i)
      * [Scenario-401: 2-Nodes Jenkins Deployment I](#scenario-401-2-nodes-jenkins-deployment-i)
      * [Scenario-402: 2-Nodes Jenkins Deployment II](#scenario-402-2-nodes-jenkins-deployment-ii)
   * [Highlights](#highlights)
   * [Contributors: Give People Credits](#contributors-give-people-credits)
   * [License](#license)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

# Scenarios

## Scenario-101: 1-Node K8S Deployment I
- Objective: Get familiar with K8S concept. Here K8S stands for Kubernetes.
- Requirements:
```
1. Start one node of k8s in your laptop. Mac or Linux
2. Start a nginx webserver with one instance
3. Scale nginx service into 2 instances.
4. Get familiar with k8s dashboard. Find pods from GUI, check nginx log.
```
- See [kubernetes.yaml](Scenario-101/kubernetes.yaml)
- Main Tech: minikube, nginx, dashboard
- See more: [Scenario-101](./Scenario-101)

## Scenario-102: 1-Node K8S Deployment II
- Objective: Single node deployment for stateful service
- Requirements:
```
1. Use yaml to start one mysql server service with 1 instance.
2. Use yaml to start one mysql client service with 2 instances.
3. Delete the db server instance, make sure a new one will be created automatically.
4. When db server is recreated, make sure no data loss.
```
- See [kubernetes.yaml](Scenario-102/kubernetes.yaml)
- Main Tech: minikube, mysql, volume
- See more: [Scenario-102](./Scenario-102)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

## Scenario-103: 1-Node K8S Deployment III
- Objective: Advanced k8s deployment for one single db service
- Requirements:
```
1. In yaml, define a k8s namespace. Thus we can segreate different k8s envs
2. Make sure we can't start 2 pods for DB server by creating a ResourceQuota
3. When we initialize mysql, pass mysql root password in a secured way
4. Use StatefulSet to create one mysql db instance in yaml
5. When db first started, create a dummy table and dummy records
6. When db process has failed, make sure a new one will be started and no data loss
```
- See [kubernetes.yaml](Scenario-103/kubernetes.yaml)
- Main Tech: minikube, mysql, volume, Job
- See more: [Scenario-103](./Scenario-103)
- TODO

## Scenario-201: 2-Nodes K8S Deployment I
- Objective: Understand k8s cluster model
- Requirements:
```
1. Deploy 2 nodes k8s
2. Create a nginx service, with 3 instances
3. Run performance test, meanwhile kill one or two nginx instace. Confirm the error rate is low.
4. Avoid SPOF: Shutdown one node, make sure nginx service is still up and running
```
- Main Tech:
- See more: [Scenario-201](./Scenario-201)
- TODO

## Scenario-202: 2-Nodes K8S Deployment II
- Objective: k8s cluster env with stateful service
- Requirements:
```
1. Deploy 2 nodes k8s
2. Create a mysql service, with 3 instances. 1 master 2 slave
3. Avoid SPOF: Shutdown one node, make sure nginx service is still up and running
```
- Main Tech:
- See more: [Scenario-202](./Scenario-202)
- TODO

## Scenario-301: 2-Nodes Elasticsearch Deployment I
- Objective: Real service deployment for db service
- Requirements:
```
1. Deploy elasticsearch k8s cluster with 3 nodes. Configure the replica count to 3.
2. Simulate node crash event and make sure no data loss. And no downtime.
```
- Main Tech:
- See more: [Scenario-301](./Scenario-301)
- TODO

## Scenario-401: 2-Nodes Jenkins Deployment I
- Objective: Real service deployment
- Requirements:
```
1. Deploy 2 nodes Jenkins. 1 master 2 slaves
2. When Jenkins crash, get alerts
```
- Main Tech:
- See more: [Scenario-401](./Scenario-401)
- TODO

## Scenario-402: 2-Nodes Jenkins Deployment II
- Objective: Real service deployment
- Requirements:
```
1. Finish Scenario-401
2. When jenkins master crash, make sure service doesn't crash
3. Use nginx as an ingress for Jenkins master
```
- Main Tech:
- See more: [Scenario-402](./Scenario-402)
- TODO

<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

# Highlights
- TODO

- More resources
```
- http://containertutorials.com/get_started_kubernetes/k8s_example.html
- https://kubernetes.io/docs/getting-started-guides/scratch/
- https://github.com/kelseyhightower/kubernetes-the-hard-way
- https://kubernetes.io/docs/tutorials/

kubernetes examples in GitHub From Google
https://github.com/kubernetes/examples

Configuration Best Practices
https://kubernetes.io/docs/concepts/configuration/overview/
```

# Contributors: Give People Credits
Below are folks who have contributed via GitHub!

# License
- Code is licensed under [MIT License](https://www.dennyzhang.com/wp-content/mit_license.txt).

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
