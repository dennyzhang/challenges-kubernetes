all: 

.PHONY: prep
prep:
	kubectl taint nodes --all dedicated- || echo "OK"

.PHONY: image
image: Dockerfile hello-client.go
	sudo docker build -t hello-client .

.PHONY: run
run:
	kubectl run hello-client --image=hello-client --image-pull-policy=Never --restart=Never --overrides='{"apiVersion":"v1", "spec": {"nodeSelector":{"kubernetes.io/hostname":"k8s1"}}}'

.PHONY: logs
logs:
	kubectl logs hello-client

.PHONY: clean
clean:
	kubectl delete po hello-client
