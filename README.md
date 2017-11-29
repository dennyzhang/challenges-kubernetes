# kubernetes-challenges

[![Build Status](https://travis-ci.org/DennyZhang/kubernetes-challenges.svg?branch=master)](https://travis-ci.org/DennyZhang/kubernetes-challenges) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

[![LinkedIn](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) <a href="https://www.dennyzhang.com/slack" target="_blank" rel="nofollow"><img src="http://slack.dennyzhang.com/badge.svg" alt="slack"/></a> [![Github](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/github.png)](https://github.com/DennyZhang)

File me [tickets](https://github.com/DennyZhang/kubernetes-challenges/issues) or star [the repo](https://github.com/DennyZhang/kubernetes-challenges).

<a href="https://github.com/DennyZhang?tab=followers"><img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/fork_github.png" /></a>

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/kubernetes-challenges/master/images/kubernetes.png"/> </a>

Table of Contents
=================

   * [Scenarios](#scenarios)
      * [Scenario-101: Docker Single-Node Jenkins Deployment I](#scenario-101-docker-single-node-jenkins-deployment-i)
      * [Scenario-102: Docker Single-Node Jenkins Deployment II](#scenario-102-docker-single-node-jenkins-deployment-ii)
   * [Contributors: Give People Credits](#contributors-give-people-credits)
   * [License](#license)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

Challenges Your Kubernetes Skills And Knowledge

**Similar Challenges**: https://www.dennyzhang.com/battle

# Scenarios

## Scenario-101: Docker Single-Node Jenkins Deployment I
- Objective: Deploy Docker container in AWS
- Requirements:
```
1. Start an EC2 instance by cloudformation
2. Provision the instance as docker daemon
3. Setup Jenkins container inside the instance
```
- Main Tech: Cloudformation, Docker

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-101.yml)
- See more: [Scenario-101](./Scenario-101)

## Scenario-102: Docker Single-Node Jenkins Deployment II
- Objective: Customize Jenkins docker deployment in AWS
- Requirements:
```
1. Finish Scenario-101, create a jenkins user by code.
2. Anonymous user can't open the jenkins. Only login user can.
3. When Jenkins is down, get alerts
4. Make sure Jenkins GUI changes can be seamlessly tracked in git repo.
```
- Main Tech: Cloudformation, Docker

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-102.yml)
- See more: [Scenario-102](./Scenario-102)
- TODO

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/kubernetes-challenges/master/images/jenkins_docker_aio.png"/> </a>

- **Highlights For This Case Study**
TOOD

# Contributors: Give People Credits
Below are folks who have contributed via GitHub!

# License
- Code is licensed under [MIT License](https://www.dennyzhang.com/wp-content/mit_license.txt).

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
