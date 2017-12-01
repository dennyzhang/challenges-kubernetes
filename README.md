# challenges-kubernetes

[![Build Status](https://travis-ci.org/DennyZhang/challenges-kubernetes.svg?branch=master)](https://travis-ci.org/DennyZhang/challenges-kubernetes) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

[![LinkedIn](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) <a href="https://www.dennyzhang.com/slack" target="_blank" rel="nofollow"><img src="http://slack.dennyzhang.com/badge.svg" alt="slack"/></a> [![Github](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/github.png)](https://github.com/DennyZhang)

File me [tickets](https://github.com/DennyZhang/challenges-kubernetes/issues) or star [the repo](https://github.com/DennyZhang/challenges-kubernetes).

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
      * [Scenario-301: 2-Nodes Jenkins Deployment I](#scenario-301-2-nodes-jenkins-deployment-i)
      * [Scenario-302: 2-Nodes Jenkins Deployment II](#scenario-302-2-nodes-jenkins-deployment-ii)
   * [Highlights](#highlights)
   * [Contributors: Give People Credits](#contributors-give-people-credits)
   * [License](#license)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

See more challenges from Denny: [here](https://www.dennyzhang.com/battle)

# Scenarios

## Scenario-101: 1-Node K8S Deployment I
- Objective: Get familiar with K8S concept. Here K8S stands for Kubernetes.
- Requirements:
```
1. Start one node of k8s in your laptop. Mac or Linux
2. Start a nginx webserver, which stateless
```
- Main Tech: minikube
- See more: [Scenario-101](./Scenario-101)

## Scenario-102: 1-Node K8S Deployment II
- Objective: Get familiar with K8S concept
- Requirements:
```
1. Finish Scenario-101
2. Autoscale the service from 1 instance to 2 instance
3. Setup two nginx vhosts. And run performance test, make sure the load is balanced
```
- Main Tech:
- See more: [Scenario-102](./Scenario-102)

## Scenario-103: 1-Node K8S Deployment III
- Objective: Single node deployment for stateful service
- Requirements:
```
1. Start one node of k8s in your laptop.
2. Start a mysql service with only 2 instance. 1 master, 1 slave
3. Attach volume for mysql data
4. Kill current mysql pod, make sure a new instance will start automatically.
```
- Main Tech:
- See more: [Scenario-103](./Scenario-103)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

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

## Scenario-301: 2-Nodes Jenkins Deployment I
- Objective: Real service deployment
- Requirements:
```
1. Deploy 2 nodes Jenkins. 1 master 2 slaves
2. When Jenkins crash, get alerts
```
- Main Tech:
- See more: [Scenario-301](./Scenario-301)

## Scenario-302: 2-Nodes Jenkins Deployment II
- Objective: Real service deployment
- Requirements:
```
1. Finish Scenario-301
2. When jenkins master crash, make sure service doesn't crash
3. Use nginx as an ingress for Jenkins master
```
- Main Tech:
- See more: [Scenario-302](./Scenario-302)

<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

# Highlights

- TOOD

# Contributors: Give People Credits
Below are folks who have contributed via GitHub!

# License
- Code is licensed under [MIT License](https://www.dennyzhang.com/wp-content/mit_license.txt).

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>