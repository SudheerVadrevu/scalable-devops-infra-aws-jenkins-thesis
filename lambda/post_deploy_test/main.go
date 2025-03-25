package main

import (
	"context"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"strings"

	"github.com/aws/aws-lambda-go/lambda"
)

var bodyCharNum int = 300

type deployEvent struct {
	URL       string   `json:"url"`
	Endpoints []string `json:"endpoints"`
}

type httpResponse struct {
	url      string
	response *http.Response
	err      error
	body     string
}

type testResult struct {
	Message    string            `json:"msg"`
	PassedRate float32           `json:"passing rate"`
	Result     map[string]string `json: result of each endpoints`
}

func keepChars(s string, n int) (result string) {
	if len(s) < n {
		result = s
	} else {
		result = s[:n]
	}
	return strings.Replace(result, "\r", "", -1)
}

func execTests(baseURL string, endpoints []string, ch chan<- *httpResponse) {
	for _, endpoint := range endpoints {
		url := baseURL + endpoint
		go func(url string) {
			fmt.Printf("Testing the url %s \n", url)
			resp, err := http.Get(url)
			body, _ := ioutil.ReadAll(resp.Body)
			defer resp.Body.Close()
			ch <- &httpResponse{url, resp, err, string(body)}
		}(url)
	}
}

func prettyPrint(v interface{}) string {
	b, err := json.MarshalIndent(v, "", "  ")
	if err == nil {
		return fmt.Sprintln(string(b))
	}
	return fmt.Sprintln(err)
}

func onDeployed(ctx context.Context, deploy deployEvent) (testResult, error) {
	result := make(map[string]string)
	endpoints := deploy.Endpoints
	ch := make(chan *httpResponse, len(endpoints))
	var successNum, totalNum int = 0, 0
	execTests(deploy.URL, endpoints, ch)
	for {
		select {
		case r := <-ch:
			totalNum++
			fmt.Printf("Get result of url: %s \n", r.url)
			if r.response.StatusCode != 200 || r.err != nil {
				result[r.url] = fmt.Sprintf("Failed, status code %d, error %s", r.response.StatusCode, r.err)
			} else {
				result[r.url] = fmt.Sprintf("Succeed, response body (first %d characters): %s", bodyCharNum, keepChars(r.body, bodyCharNum))
				successNum++
			}
			fmt.Printf("%d out of %d endpoints tested, %d succeed \n", totalNum, len(endpoints), successNum)
			if totalNum == len(endpoints) {
				fmt.Println("All endpoints are tested, result:\n", prettyPrint(result))
				return testResult{fmt.Sprintf("Test is done, %d out of %d was succeed \n", successNum, len(result)), float32(successNum) / float32(len(result)), result}, nil
			}
		}

	}
	return testResult{fmt.Sprintf("Test not finished"), 0.0, result}, nil
}

func main() {
	lambda.Start(onDeployed)
}
