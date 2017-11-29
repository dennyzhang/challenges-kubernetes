# kubernetes-challenges

[![Build Status](https://travis-ci.org/DennyZhang/kubernetes-challenges.svg?branch=master)](https://travis-ci.org/DennyZhang/kubernetes-challenges) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

[![LinkedIn](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) <a href="https://www.dennyzhang.com/slack" target="_blank" rel="nofollow"><img src="http://slack.dennyzhang.com/badge.svg" alt="slack"/></a> [![Github](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/github.png)](https://github.com/DennyZhang)

File me [tickets](https://github.com/DennyZhang/kubernetes-challenges/issues) or star [the repo](https://github.com/DennyZhang/kubernetes-challenges).

<a href="https://github.com/DennyZhang?tab=followers"><img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/fork_github.png" /></a>

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/kubernetes-challenges/master/images/kubernetes.png"/> </a>

Table of Contents
=================

   * [Scenarios](#scenarios)
      * [Scenario-101: Single-Node K8S Deployment I](#scenario-101-single-node-k8s-deployment-i)
      * [Scenario-102: Single-Node K8S Deployment II](#scenario-102-single-node-k8s-deployment-ii)
      * [Scenario-103: Single-Node K8S Deployment III](#scenario-103-single-node-k8s-deployment-iii)
      * [Scenario-201: 2-Nodes K8S Deployment I](#scenario-201-2-nodes-k8s-deployment-i)
      * [Scenario-202: 2-Nodes K8S Deployment II](#scenario-202-2-nodes-k8s-deployment-ii)
   * [Contributors: Give People Credits](#contributors-give-people-credits)
   * [License](#license)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

Challenges Your Kubernetes Skills And Knowledge

**Similar Challenges**: https://www.dennyzhang.com/battle

# Scenarios

## Scenario-101: Single-Node K8S Deployment I
- Objective: Get familiar with K8S concept
- Requirements:
```
1. Start one node of k8s in your laptop. Mac or Linux
2. Start a nginx webserver, which stateless
3. Autoscale the service from 1 instance to 2 instance
```
- Main Tech: minikube
- See more: [Scenario-101](./Scenario-101)

## Scenario-102: Single-Node K8S Deployment II
- Objective: Single node deployment for stateful service
- Requirements:
```
1. Finish Scenario-101
2. Start a mysql service with only one instance
3. Kill current mysql pod, make sure a new instance will start automatically.
```
- Main Tech: minikube
- See more: [Scenario-102](./Scenario-102)

## Scenario-103: Single-Node K8S Deployment III
- Objective: Single node deployment for stateful service
- Requirements:
```
1. Finish Scenario-102
2. Start a mysql service with only 2 instance. 1 master, 1 slave
3. Kill current mysql pod, make sure a new instance will start automatically.
```
- Main Tech: minikube
- See more: [Scenario-103](./Scenario-103)

## Scenario-201: 2-Nodes K8S Deployment I
- Objective: Understand k8s cluster model
- Requirements:
```
1. Deploy 2 nodes k8s
2. Create a nginx service, with 3 instances
3. Run performance test, meanwhile kill one or two nginx instace. Confirm the error rate is low.
4. Avoid SPOF: Shutdown one node, make sure nginx service is still up and running
```
- Main Tech: minikube
- See more: [Scenario-201](./Scenario-201)

## Scenario-202: 2-Nodes K8S Deployment II
- Objective: k8s cluster env with stateful service
- Requirements:
```
1. Deploy 2 nodes k8s
2. Create a mysql service, with 3 instances. 1 master 2 slave
3. Avoid SPOF: Shutdown one node, make sure nginx service is still up and running
```
- Main Tech: minikube
- See more: [Scenario-202](./Scenario-202)

- **Highlights For This Case Study**
TOOD

# Contributors: Give People Credits
Below are folks who have contributed via GitHub!

# License
- Code is licensed under [MIT License](https://www.dennyzhang.com/wp-content/mit_license.txt).

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
