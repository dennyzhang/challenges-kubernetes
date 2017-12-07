# Kubernetes Playground
This project contains a `Vagrantfile` and associated `Ansible` playbook scripts
to provisioning a 3 nodes Kubernetes cluster using `VirtualBox` and `Ubuntu
16.04`.

### Prerequisites
You need the following installed to use this playground.
- `Vagrant`, version 1.9.3 or better. Earlier versions of vagrant do not work
with the Vagrant Ubuntu 16.04 box and network configuration.
- `VirtualBox`, tested with Version 5.1.18 r114002
- Internet access, this playground pulls Vagrant boxes from the Internet as well
as installs Ubuntu application packages from the Internet.

### Bringing Up The cluster
To bring up the cluster, clone this repository to a working directory.

```
git clone http://github.com/davidkbainbridge/k8s-playground
```

Change into the working directory and `vagrant up`

```
cd k8s-playground
vagrant up
```

Vagrant will start three machines. Each machine will have a NAT-ed network
interface, through which it can access the Internet, and a `private-network`
interface in the subnet 172.42.42.0/24. The private network is used for
intra-cluster communication.

The machines created are:

| NAME | IP ADDRESS | ROLE |
| --- | --- | --- |
| k8s1 | 172.42.42.1 | Cluster Master |
| k8s2 | 172.42.42.2 | Cluster Worker |
| k8s3 | 172.42.42.3 | Cluster Worker |

As the cluster brought up the cluster master (**k8s1**) will perform a `kubeadm
init` and the cluster workers will perform a `kubeadmin join`. This cluster is
using a static Kubernetes cluster token.

After the `vagrant up` is complete, the following command and output should be
visible on the cluster master (**k8s1**).

```
vagrant ssh k8s1
kubectl -n kube-system get po -o wide

NAME                             READY     STATUS              RESTARTS   AGE       IP            NODE
etcd-k8s1                        1/1       Running             0          10m       172.42.42.1   k8s1
kube-apiserver-k8s1              1/1       Running             1          10m       172.42.42.1   k8s1
kube-controller-manager-k8s1     1/1       Running             0          11m       172.42.42.1   k8s1
kube-discovery-982812725-pv5ib   1/1       Running             0          11m       172.42.42.1   k8s1
kube-dns-2247936740-cucu9        0/3       ContainerCreating   0          10m       <none>        k8s1
kube-proxy-amd64-kt8d6           1/1       Running             0          10m       172.42.42.1   k8s1
kube-proxy-amd64-o73p7           1/1       Running             0          5m        172.42.42.3   k8s3
kube-proxy-amd64-piie9           1/1       Running             0          8m        172.42.42.2   k8s2
kube-scheduler-k8s1              1/1       Running             0          11m       172.42.42.1   k8s1
```

### Starting Networking
Stating the clustering networking is **NOT** automated and must be completed
after the `vagrant up` is complete. A script to start the networking is
installed on the cluster master (**k8s1**) as `/usr/local/bin/start-weave`.

```
vagrant ssh k8s1
ubuntu@k8s1:~$ start-weave
clusterrole "weave-net" created
serviceaccount "weave-net" created
clusterrolebinding "weave-net" created
daemonset "weave-net" created
```

After the network is started, assuming `weave-net` is used, the following
command and output should be visible on the master node (**k8s1**):

```
vagrant ssh k8s1
$ kubectl -n kube-system get po -o wide
NAME                             READY     STATUS    RESTARTS   AGE       IP            NODE
etcd-k8s1                        1/1       Running   0          14m       172.42.42.1   k8s1
kube-apiserver-k8s1              1/1       Running   1          13m       172.42.42.1   k8s1
kube-controller-manager-k8s1     1/1       Running   0          14m       172.42.42.1   k8s1
kube-discovery-982812725-pv5ib   1/1       Running   0          14m       172.42.42.1   k8s1
kube-dns-2247936740-cucu9        3/3       Running   0          14m       10.40.0.1     k8s1
kube-proxy-amd64-kt8d6           1/1       Running   0          13m       172.42.42.1   k8s1
kube-proxy-amd64-o73p7           1/1       Running   0          8m        172.42.42.3   k8s3
kube-proxy-amd64-piie9           1/1       Running   0          11m       172.42.42.2   k8s2
kube-scheduler-k8s1              1/1       Running   0          14m       172.42.42.1   k8s1
weave-net-33rjx                  2/2       Running   0          3m        172.42.42.2   k8s2
weave-net-3z7jj                  2/2       Running   0          3m        172.42.42.1   k8s1
weave-net-uvv48                  2/2       Running   0          3m        172.42.42.3   k8s3
```

### Starting A Sample Service / Deployment
Included in the *git* repository is a sample *service* and *deployment*
specification that work with Kubernetes. These can be found on the master node
(**k8s1**) as `/vagrant/service.yml` and `/vagrant/deployment.yml`.

These descriptors will create a *hello-service* sample service using a simple
docker image `davidkbainbridge/docker-hello-world`. This image is a simple
HTTP service that outputs the the hostname and the IP address information on
which the request was processed. An example output is:

```
Hello, "/"
HOST: hello-deployment-2911225940-qhfn2
ADDRESSES:
    127.0.0.1/8
    10.40.0.5/12
    ::1/128
    fe80::dcc9:4ff:fe5c:f793/64
```

To start the *service* and *deployment* you can issue the following command
on the master node (**k8s1**):

```
kubectl create -f /vagrant/service.yml -f /vagrant/deployment.yml
```

After issuing the `create` command you should be able to see the *service* and
*deployment* using the following commands.

```
ubuntu@k8s1:~$ kubectl get service
NAME            CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
hello-service   100.76.247.60   <none>        80/TCP    6s
kubernetes      100.64.0.1      <none>        443/TCP   36m
```

```
ubuntu@k8s1:~$ kubectl get deployment
NAME               DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
hello-deployment   3         3         3            0           12s
```
*After the sample service container is pulled from dockerhub and started the
available count should go to the value `3`*.

### Fetching the Cluster DNS server
Kubernetes includes a DNS server through which service IPs and ports can be
queried. The IP address of the DNS service can be seen using the following
command:

```
kubectl -n kube-system get svc -l k8s-app=kube-dns -o json | jq -r '.items[].spec.clusterIP'
```

The IP address of the DNS server will be used in some of the following commands,
such as `dig` in for form `@a.b.c.d`. Please substitute the IP address returned
about into this commands.

### Accessing the Service
Kubernetes creates a SRV record in its DNS server for the service that was
defined in the `service.yml` file. Looking at this file you can see that a
service named `http` was defined. This information can be queried from DNS
use the following command:
```
ubuntu@k8s1:~$ dig +short  @a.b.c.d _http._tcp.hello-service.default.svc.cluster.local SRV
10 100 80 hello-service.default.svc.cluster.local.
```

The information returned form this query is of the form:
```
<priority> <weight> <port> <target>
```

Using a query recursively on this information, specifically the `target` the
IP address for the service can be retrieved.
```
ubuntu@k8s1:~$ dig +short  @a.b.c.d hello-service.default.svc.cluster.local.
100.76.247.60
```

Thus using DNS a client can dynamically determine the IP address and the port
on which to connect to a service. To test the service the following command
can be used on any node in the cluster:
```
curl -sSL http://$(dig +short @a.b.c.d $(dig +short  @a.b.c.d \
     _http._tcp.hello-service.default.svc.cluster.local SRV | cut '-d ' -f4)):\
     $(dig +short @a.b.c.d _http._tcp.hello-service.default.svc.cluster.local SRV | cut '-d ' -f3)
```

A script has been provided to simplify this tasks and returns the host IP and the
port given a DNS server and service. Thus the same results can be acheived in
the playground with the following command:
```
curl -sSL http://$(/vagrant/kube-target _http._tcp.hello-service.default.svc.cluster.local)
```

The IP address for the service can also be seen via the `kubectl get service`
command.

The IP address returned in every enivornment may be differet.

To test the service you can use the following command on any node in the
cluster:

```
ubuntu@k8s1:~$ curl -sSL http://$(/vagrant/kube-target _http._tcp.hello-service.default.svc.cluster.local)
Hello, "/"
HOST: hello-deployment-2911225940-b3tyn
ADDRESSES:
    127.0.0.1/8
    10.32.0.2/12
    ::1/128
    fe80::e89f:bfff:fec2:b67a/64
```

### Scaling the Service
To test the scaling of the service, you can open a second terminal and ssh
to a node in the cluster (e.g. `vagrant up ssh k8s1`). In this terminal if you
issue the following command it will periodically issue a `curl` request to
the service and display the output, highlighting the difference from the
previous request. This demonstates that the request is being handled by
different services.

```
watch -d curl -sSL http://$(/vagrant/kube-target  _http._tcp.hello-service.default.svc.cluster.local)
```

Currently there should be 3 instances of the service implementation being
used. To scale to a single instance, issue the following command:

```
ubuntu@k8s1:~$ kubectl scale deployment hello-deployment --replicas=1
deployment "hello-deployment" scaled
```

After scaling to a single instance the `watch` command from above should show
no differences between successive request as all requests are being handled by
the same instance.

The following command scales the number of instances to 5 and after issuing
this command differences in the `watch` command should be highlighted.

```
ubuntu@k8s1:~$ kubectl scale deployment hello-deployment --replicas=5
deployment "hello-deployment" scaled
```

### Service Health Check
The test container image used above `davidkbainbridge/docker-hello-world:latest`
is built with a health check capability. The container provides a REST end
point that will return `200 Ok` by default, but this can be manual set to a
different value to test error cases. See the container documentation
at https://github.com/davidkbainbridge/docker-hello-world for more information.

To see the health of any given instance of the service implementation, you can
`ssh` to the k8s1 and perform a `kubectl get po -o wide`. This will show the
pods augmented with the number of restarts.

```
ubuntu@k8s1:~$ kubectl get po -o wide
NAME                                READY     STATUS    RESTARTS   AGE       IP          NODE
hello-deployment-3696513547-fhh2y   1/1       Running   0          12s       10.40.0.1   k8s2
hello-deployment-3696513547-ocgas   1/1       Running   0          12s       10.38.0.2   k8s3
hello-deployment-3696513547-y257u   1/1       Running   0          12s       10.38.0.1   k8s3
```

To demonstrate the health check capability of the cluster, you can open up a
`ssh` session to k8s1 and run `watch -d kubectl get po -o wide`. This command
will periodically update the screen with information about the pods including
the number of restarts.

To cause one of the container instances to start reporting a failed health
value you can set a random instance to fail using

```
curl -XPOST -sSL http://$(/vagrant/kube-target  _http._tcp.hello-service.default.svc.cluster.local)/health -d '{"status":501}'
```

This will set the health check on a random instance in the cluster to return
"501 Internal Server Error". If you want to fail the health check on a specific
instance you will nee to make a similar `curl` request to the specific
container instance.

After setting the health check to return a failure value monitor the
`kubectl get po -o wide` command. After about 30 seconds one of the pod
restarts counts should be incremented. This represented Kubernetes killing and
restarting a pod because of a failed health check.

*NOTE: the frequency of health checks is configurable*

### Example client
Included in the repo is an example client written in the Go language that
demonstrates how a container can directly look up another service and call
that service.

To test this client use the following steps:

| COMMAND | DESCRIPTION |
| --- | --- |
| `vagrant ssh k8s1` | Logon to the k8s1 host |
| `cd /vagrant/examples/client/go` | Move to the example directory |
| `sudo apt-get -y install make` | Install the `make` command |
| `make prep` | Enables deployment of pods to the master node, `k8s1` |
| `make image` | Builds the sample client Docker image |
| `make run` | Runs the sample client as a run-once pod |
| `make logs` | Displays the logs for the client pod |
| `make clean` | Deletes the sample client pod |

The output of the `make logs` step should display a similar output as the `curl`
statement above.

```
ubuntu@k8s1:/vagrant/examples/client/go$ make logs
kubectl logs hello-client
Hello, "/"
HOST: hello-deployment-1725651635-u8f65
ADDRESSES:
    127.0.0.1/8
    10.40.0.1/12
    ::1/128
    fe80::bcdc:21ff:fecd:83db/64
```

The above example forces the deployment of the sample client to the k8s1 node
for simplicity. If you would like to have the client deployed to any of the
nodes in the cluster you need to `ssh` to each node in the cluster and

```
cd /vagrant/examples/client/go
sudo apt-get install -y make
make image
```

The run the sample client use the following commands

```
vagrant ssh k8s1
kubectl delete po hello-client
kubectl run hello-client --image=hello-client --image-pull-policy=Never --restart=Never
```

### Clean Up
On each vagrant machine is installed a utility as `/usr/local/bin/clean-k8s`.
executing this script as `sudo` will reset the servers back to a point where
you can execute vagrant provisioning.
