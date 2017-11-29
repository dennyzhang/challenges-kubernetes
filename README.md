# kubernetes-challenges

[![Build Status](https://travis-ci.org/DennyZhang/kubernetes-challenges.svg?branch=master)](https://travis-ci.org/DennyZhang/kubernetes-challenges) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

[![LinkedIn](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) <a href="https://www.dennyzhang.com/slack" target="_blank" rel="nofollow"><img src="http://slack.dennyzhang.com/badge.svg" alt="slack"/></a> [![Github](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/github.png)](https://github.com/DennyZhang)

File me [tickets](https://github.com/DennyZhang/kubernetes-challenges/issues) or star [the repo](https://github.com/DennyZhang/kubernetes-challenges).

<a href="https://github.com/DennyZhang?tab=followers"><img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/fork_github.png" /></a>

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/kubernetes-challenges/master/images/kubernetes.png"/> </a>

Table of Contents
=================
Challenges Your Kubernetes Skills And Knowledge

   * [Scenarios](#scenarios)
      * [Scenario-101: 1-Node K8S Nginx Deployment I](#scenario-101-single-node-k8s-nginx-deployment-i)
      * [Scenario-102: 1-Node K8S Nginx Deployment II](#scenario-102-single-node-k8s-nginx-deployment-ii)
      * [Scenario-201: 1-Node K8S Mysql Deployment I](#scenario-201-single-node-k8s-mysql-deployment-i)
      * [Scenario-202: 1-Node K8S Mysql Deployment II](#scenario-202-single-node-k8s-mysql-deployment-ii)
      * [Scenario-301: 2-Nodes K8S Nginx Deployment I](#scenario-301-2-nodes-k8s-nginx-deployment-i)
      * [Scenario-302: 2-Nodes K8S Nginx Deployment II](#scenario-302-2-nodes-k8s-nginx-deployment-ii)
      * [Scenario-401: 2-Nodes K8S Mysql Deployment I](#scenario-401-2-nodes-k8s-mysql-deployment-i)
   * [Highlights](#highlights)
   * [Contributors: Give People Credits](#contributors-give-people-credits)
   * [License](#license)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

**Similar Challenges**: https://www.dennyzhang.com/battle

# Scenarios

## Scenario-101: 1-Node K8S Nginx Deployment I
- Objective: Get familiar with K8S concept. Here K8S stands for Kubernetes.
- Requirements:
```
1. Start one node of k8s in your laptop. Mac or Linux
2. Start a nginx webserver, which stateless
```
- Main Tech: minikube
- See more: [Scenario-101](./Scenario-101)

## Scenario-102: 1-Node K8S Nginx Deployment II
- Objective: Get familiar with K8S concept
- Requirements:
```
1. Finish Scenario-101
2. Autoscale the service from 1 instance to 2 instance
3. Setup two nginx vhosts. And run performance test, make sure the load is balanced
```
- Main Tech: minikube
- See more: [Scenario-102](./Scenario-102)

## Scenario-201: 1-Node K8S Mysql Deployment I
- Objective: Single node deployment for stateful service
- Requirements:
```
1. Start one node of k8s in your laptop.
2. Start a mysql service with only one instance
3. Kill current mysql pod, make sure a new instance will start automatically.
```
- Main Tech: minikube
- See more: [Scenario-201](./Scenario-201)

## Scenario-202: 1-Node K8S Mysql Deployment II
- Objective: Single node deployment for stateful service
- Requirements:
```
1. Finish Scenario-202
2. Start a mysql service with only 2 instance. 1 master, 1 slave
3. Kill current mysql pod, make sure a new instance will start automatically.
```
- Main Tech: minikube
- See more: [Scenario-202](./Scenario-202)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

## Scenario-301: 2-Nodes K8S Nginx Deployment I
- Objective: Understand k8s cluster model
- Requirements:
```
1. Deploy 2 nodes k8s
2. Create a nginx service, with 3 instances
3. Run performance test, meanwhile kill one or two nginx instace. Confirm the error rate is low.
```
- Main Tech: minikube
- See more: [Scenario-301](./Scenario-301)

## Scenario-302: 2-Nodes K8S Nginx Deployment II
- Objective: Understand k8s cluster model
- Requirements:
```
1. Finish Scenario-301
4. Avoid SPOF: Shutdown one node, make sure nginx service is still up and running
```
- Main Tech:
- See more: [Scenario-302](./Scenario-302)

## Scenario-401: 2-Nodes K8S Mysql Deployment I
- Objective: k8s cluster env with stateful service
- Requirements:
```
1. Deploy 2 nodes k8s
2. Create a mysql service, with 3 instances. 1 master 2 slave
3. Avoid SPOF: Shutdown one node, make sure nginx service is still up and running
```
- Main Tech:
- See more: [Scenario-401](./Scenario-401)

# Highlights

- TOOD

<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

# Contributors: Give People Credits
Below are folks who have contributed via GitHub!

# License
- Code is licensed under [MIT License](https://www.dennyzhang.com/wp-content/mit_license.txt).
