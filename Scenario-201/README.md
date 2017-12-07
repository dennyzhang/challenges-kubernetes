<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

Table of Contents
=================

   * [1. Requirements](#1-requirements)
   * [2. Procedures](#2-procedures)
   * [3. Highlights](#3-highlights)
   * [4. More resources](#4-more-resources)

# 1. Requirements
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

```
1. Deploy 3 nodes k8s. One controller, others as worker
2. Create a nginx service with 6 instances.
3. Visit nginx service by loadbalancer. (Hint: Ingress)
```

Two different categories:
1. Setup a k8s cluster itself. Improve k8s availability and reliablity
2. Deploy clustered services in k8s cluster. Improve services' availability and reliablity

Our focus is more about category #2.

For Category #1, I have 2 recommendated GitHub Repo.
```
Start 3 nodes k8s cluster by vagrant. 1 controller 2 workers
https://github.com/davidkbainbridge/k8s-playground

Start 6 nodes k8s cluster in Google Cloud Platform. 3 controller 3 workers
https://github.com/kelseyhightower/kubernetes-the-hard-way
```

# 2. Procedures

## 2.1 Start 3 nodes local env of k8s cluster

We will use [davidkbainbridge/k8s-playground](https://github.com/davidkbainbridge/k8s-playground) to setup 3 nodes k8s cluster by virtualbox.

# 3. Highlights
- Q: 

# 4. More resources

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
