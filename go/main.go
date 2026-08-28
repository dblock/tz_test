package main

import (
	"fmt"
	"time"

	"github.com/dustin/go-humanize"
)

func main() {
	// Norfolk Island permanent offset change
	loc, _ := time.LoadLocation("Pacific/Norfolk")
	start := time.Date(2015, 1, 15, 0, 0, 0, 0, loc)
	finish := time.Date(2016, 3, 15, 0, 0, 0, 0, loc)
	_, startOffset := start.Zone()
	_, finishOffset := finish.Zone()
	fmt.Println("start offset:", startOffset, "finish offset:", finishOffset)
	fmt.Println("Norfolk RelTime:", humanize.RelTime(start, finish, "", ""))
	fmt.Println("Norfolk diff:", finish.Sub(start))

	// Dublin DST bug
	dloc, _ := time.LoadLocation("Europe/Dublin")
	dstart := time.Date(2024, 10, 27, 1, 59, 30, 0, dloc)
	dfinish := dstart.Add(1 * time.Minute)
	_, dso := dstart.Zone()
	_, dfo := dfinish.Zone()
	fmt.Println("Dublin start offset:", dso, "finish offset:", dfo)
	fmt.Println("Dublin RelTime:", humanize.RelTime(dstart, dfinish, "", ""))

	edgeCases()
}
