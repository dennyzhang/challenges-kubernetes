# kubernetes-challenges
:cloud: Challenges Your Kubernetes Skills And Knowledge

[![Build Status](https://travis-ci.org/DennyZhang/kubernetes-challenges.svg?branch=master)](https://travis-ci.org/DennyZhang/kubernetes-challenges) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

[![LinkedIn](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) <a href="https://www.dennyzhang.com/slack" target="_blank" rel="nofollow"><img src="http://slack.dennyzhang.com/badge.svg" alt="slack"/></a> [![Github](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/github.png)](https://github.com/DennyZhang)

File me [tickets](https://github.com/DennyZhang/kubernetes-challenges/issues) or star [the repo](https://github.com/DennyZhang/kubernetes-challenges).

<a href="https://github.com/DennyZhang?tab=followers"><img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/fork_github.png" /></a>

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/kubernetes-challenges/master/images/kubernetes.png"/> </a>

Table of Contents
=================

   * [kubernetes-challenges](#kubernetes-challenges)
   * [Scenarios](#scenarios)
      * [Scenario-101: Docker Single-Node Jenkins Deployment I](#scenario-101-docker-single-node-jenkins-deployment-i)
      * [Scenario-102: Docker Single-Node Jenkins Deployment II](#scenario-102-docker-single-node-jenkins-deployment-ii)
      * [Scenario-201: VM Single-Node Jenkins Deployment I](#scenario-201-vm-single-node-jenkins-deployment-i)
      * [Scenario-202: VM Single-Node Jenkins Deployment II](#scenario-202-vm-single-node-jenkins-deployment-ii)
      * [Scenario-203: VM Single-Node Jenkins Deployment III](#scenario-203-vm-single-node-jenkins-deployment-iii)
      * [Scenario-301: VM ASG/ELB Jenkins Deployment I](#scenario-301-vm-asgelb-jenkins-deployment-i)
   * [Highlights](#highlights)
   * [Contributors: Give People Credits](#contributors-give-people-credits)
   * [License](#license)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

Case study using AWS TechStack to setup Jenkins env

**Related GitHub Repos**:
- [chef-study](https://github.com/DennyZhang/chef-study): Chef Case study from dummies to pros
- [jenkins-groovy-study](https://github.com/DennyZhang/jenkins-groovy-study): Case Study: Use groovy and Pipeline in Jenkins as a Pro
- [kubernetes-challenges](https://github.com/DennyZhang/kubernetes-challenges): Case Study Using AWS To Setup Jenkins.

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

## Scenario-201: VM Single-Node Jenkins Deployment I
- Objective: We need a live Jenkins env in public Cloud. Fast and easy.
- Requirements:
```
1. Use cloudformation to start an EC2 instance
2. Start Jenkins inside the EC2 instance
```
- Main Tech: Cloudformation, Chef

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-201.yml)
- See more: [Scenario-201](./Scenario-201)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

## Scenario-202: VM Single-Node Jenkins Deployment II
- Objective: Customize Jenkins docker deployment in AWS
- Requirements:
```
1. Finish Scenario-201, create a jenkins user by code.
2. Create a dedicated VPC for the jenkins. And allow selective source IP to access.
3. Anonymous user can't open the jenkins. Only login user can.
4. Make sure Jenkins GUI changes can be seamlessly tracked in git repo.
```
- Main Tech: Cloudformation, Chef, VPC, Slack

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-202.yml)
- See more: [Scenario-202](./Scenario-202)

## Scenario-203: VM Single-Node Jenkins Deployment III
- Objective: Customize Jenkins docker deployment in AWS
- Requirements:
```
1. Finish Scenario-202
2. Use CF to create a dedicated VPC and start an EC2
```
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, Slack

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-203.yml)
- See more: [Scenario-203](./Scenario-203)
- TODO

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/kubernetes-challenges/master/images/jenkins_vm_aio.png"/> </a>

## Scenario-301: VM ASG/ELB Jenkins Deployment I
- Objective: Customize Jenkins docker deployment in AWS
- Requirements:
```
1. Use CF to create ASG and ELB. And monitor ELB
2. Start Jenkins master by ELB. Configure instance count to 1
```
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, Slack

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-301.yml)
- See more: [Scenario-301](./Scenario-301)

## Scenario-302: VM ASG/ELB Jenkins Deployment II
- Objective: Customize Jenkins docker deployment in AWS
- Requirements:
```
1. Finish Scenario-301
2. Get slack notificaiton for autoscaling events.
   Here we assume, one SNS topic has already been created.
   Verify it by terminating existing instance
3. In ELB, enable monitoring
   Verify it by terminating existing instance
4. In Jenkins deployment, create a pipeline
```
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, Slack

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-302.yml)
- See more: [Scenario-302](./Scenario-302)

## Scenario-303: VM ASG/ELB Jenkins Deployment II
- Objective: Customize Jenkins docker deployment in AWS
- Requirements:
```
1. Finish Scenario-302
2. ELB export target group
3. Enable logging for ELB
4. When SNSTopicName is empty, avoid adding SNS notification
```
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, Slack

- TODO

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-303.yml)
- See more: [Scenario-303](./Scenario-303)

## Scenario-401: VM 2-Nodes Jenkins Deployment I
- Objective: Avoid SPOF by adding 2 Jenkins instance
- Requirements:
```
1. Start 1 jenkins master and 1 jenkins slave
2. Jenkins master offload request to jenkins slave
```
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, Jenkins Slack Integration, ALB

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-401.yml)
- See more: [Scenario-401](./Scenario-401)
- TODO
- TODO: how the 2 Jenkins instance gonna to coordinate with each other?

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

## Scenario-402: VM 2-Nodes Jenkins Deployment II
- Objective: Jenkins cluster deployment
- Requirements:
```
1. Start 1 jenkins master and 1 jenkins slave
2. Enable auto-scaling for Jenkins master. With instance count 1
3. Enable auto-scaling for Jenkins slaves. With instance count range from 1 to 3
4. Customized VPC to allow limited network access
```
- Main Tech: Cloudformation, Chef, VPC, CloudWatch, EBS, Jenkins Slack Integration, ALB

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-402.yml)
- See more: [Scenario-402](./Scenario-402)
- TODO

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/kubernetes-challenges/master/images/jenkins_vm_2nodes.png"/> </a>

## Scenario-501: ECS Jenkins Deployment I
- Objective: Get exposed to docker orchestration service.
- Requirements:
```
1. Start ECS with 1 node
2. Install a single Jenkins instance
```
- Main Tech: Cloudformation, ECS, EBS

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-501.yml)
- See more: [Scenario-501](./Scenario-501)
- TODO

## Scenario-502: ECS Jenkins Deployment II
- Objective: Deploy a 2-nodes Jenkins cluster
- Requirements:
```
1. Start ECS with 2 node
2. Start Jenkins service with 2 instances in ECS. One for master, one for slave.
3. Enable ALB for Jenkins master
```
- Main Tech: Cloudformation, ECS, ELB, CloudWatch, ALB

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-502.yml)
- See more: [Scenario-502](./Scenario-502)
- TODO
- TODO: How to avoid Jenkins SPOF, theoretically speaking?

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/kubernetes-challenges/master/images/jenkins_ecs_2nodes.png"/> </a>

## Scenario-503: ECS Jenkins Deployment III
- Objective: Deploy Jenkins 1 Master 3 Slaves with 2 nodes in ECS2
- Requirements:
```
1. Start ECS with 2 node
2. Start Jenkins service within ECS. 1 Master and 3 Slaves
3. Enable ALB for Jenkins master
```
- Main Tech: Cloudformation, ECS, ELB, CloudWatch, ALB

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-503.yml)
- See more: [Scenario-503](./Scenario-503)
- TODO
- TODO: How to avoid Jenkins SPOF, theoretically speaking?

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/kubernetes-challenges/master/images/jenkins_ecs_2nodes_4instances.png"/> </a>

## Scenario-601: Large Scale Jenkins Deployment I
- Objective: Suppose you have 1K developers to use your Jenkins. Improve scalability, availability, security, etc.
- Requirements:
```
1. Scalability: multiple Jenkins master instances
2. Availability: Jenkins slave; Jenkins Master
2. Security: VPC, Jenkins authentication integration
```
- Main Tech: Cloudformation, ECS, EBS, ALB

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=aws-jenkins&templateURL=https://s3.amazonaws.com/aws.dennyzhang.com/cf-jenkins-main-601.yml)
- See more: [Scenario-601](./Scenario-601)
- TODO

<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/kubernetes-challenges/master/images/jenkins_master_ha.png"/> </a>

<a href="https://www.dennyzhang.com"><img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/magic.gif"></a>
# Highlights

- **Highlights For This Case Study**
```
1. OS support: Amazon AMI, Ubuntu and CentOS
2. Use CF to fully automate all deployments
3. Auto-healing: autoscaling group. Improved service availability
4. When issues have happened, we detect it earlier.
5. Pretty secured
6. Quick learner: I have never used CF before.
   This GitHub repo is the deliverable of 1.5 weeks' part time work.
```

- Discussions & Further Improvements:

TOOD
```
0. Use docker/ecs/k8s
1. Speed up the whole setup process
2. Reduce the deployment failure rate
3. Improve master HA by using EFS for shared storage of Jenkins HOME
4. Setup 1 master N slaves models
5. Improve error handling. e.g, False positive. when EC2 instance is up, but chef apply hasn't finished
6. Save the cloud bills
7. Use serverless instead of Jenkins hosted solution
8. Use CodeDeploy to replace Chef
```

- Personal Review:
```
1. Really like container/ECS deployment over VM deployment.
2. Jenkins community don't have HA solution for Jenkins master yet.
3. Jenkins plugins dependency is really troublesome.
```

- More Resources:
```
https://github.com/widdix/aws-cf-templates
https://github.com/awslabs/startup-kit-templates
http://templates.cloudonaut.io/en/stable/jenkins/

# Jenkins Security
https://wiki.jenkins.io/display/JENKINS/Standard+Security+Setup
https://d0.awsstatic.com/whitepapers/DevOps/Jenkins_on_AWS.pdf
```

# Contributors: Give People Credits
Below are folks who have contributed via GitHub!
- Critical Info
```
# Centos Jenkins Conf
/etc/sysconfig/jenkins

# Run chef deployment
chef-solo --config "/home/ec2-user/chef/solo.rb" \
  --log_level auto -L "/home/ec2-user/log/run_chef_solo.log" \
  --force-formatter --no-color --json-attributes "/home/ec2-user/chef/node.json"
```

# License
- Code is licensed under [MIT License](https://www.dennyzhang.com/wp-content/mit_license.txt).

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
