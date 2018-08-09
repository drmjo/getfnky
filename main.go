package main

import (
	"flag"
	"fmt"
	"os"
)

func main() {
	getFn := flag.String("get", "", "Get command fetches the requested function.")

	flag.Parse()

	if *getFn == "" {
		flag.PrintDefaults()
		os.Exit(1)
	}
	}
	fmt.Printf("getFn: %s", *getFn)
}
