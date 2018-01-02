package main

import (
	"fmt"
	"io/ioutil"
	"net"
	"net/http"
)

func main() {
	// Lookup the SRV record for the hello service
	_, srvs, err := net.LookupSRV("http", "tcp", "hello-service.default.svc.cluster.local")
	if err != nil {
		panic(err)
	}

	// The assumption is that there is only SRV record, there could be more in theory
	srv := srvs[0]

	// Go Ask the service for a response
	resp, err := http.Get(fmt.Sprintf("http://%s:%d", srv.Target, srv.Port))

	if err != nil {
		panic(err)
	}

	// Read the data from the GET response
	data, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		panic(err)
	}

	// Display the response
	fmt.Println(string(data))
}
