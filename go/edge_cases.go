package main

import (
	"fmt"
	"time"

	"github.com/dustin/go-humanize"
)

func edgeCases() {
	a := time.Date(2015, 1, 15, 0, 0, 0, 0, time.UTC)
	b := time.Date(2016, 3, 15, 0, 0, 0, 0, time.UTC)

	fmt.Println("--- reversed order (finish before start) ---")
	fmt.Println("RelTime forward:", humanize.RelTime(a, b, "", ""))
	fmt.Println("RelTime reversed:", humanize.RelTime(b, a, "", ""))

	fmt.Println("--- zero distance (same instant) ---")
	fmt.Println("RelTime:", humanize.RelTime(a, a, "", ""))
}
