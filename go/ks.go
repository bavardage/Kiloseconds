package main

import (
	"fmt"
	"time"
)



func main() {
	now := time.LocalTime()
	seconds := (now.Hour * 3600) + (now.Minute * 60) + now.Second
	fmt.Printf("It is %.3f kiloseconds\n", (float64(seconds) / 1000))
}

