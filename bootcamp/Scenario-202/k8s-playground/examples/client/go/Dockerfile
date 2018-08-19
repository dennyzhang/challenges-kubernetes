FROM golang:alpine

ADD . /go/src/github.com/k8s-playground/example

RUN go install github.com/k8s-playground/example

ENV GODEBUG=netdns=go
ENTRYPOINT ["/go/bin/example"]
