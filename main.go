package main

import (
	"fmt"
	"html/template"
	"net/http"
	"time"
)

type Person struct {
	Name, Surrname string
}

var p = []Person{
	{Name: "Stefan", Surrname: "Wilk"},
	{Name: "Borek", Surrname: "Wilk"},
	{Name: "Henryk", Surrname: "Glaca"},
}

func home(w http.ResponseWriter, req *http.Request) {
	t := template.Must(template.ParseFiles("home.html"))
	p = append(p, <-newData)
	t.Execute(w, p)
}

func main() {
	newData := make(chan []Person, 1)
	go func() {
		counter := 0
		for {
			newPerson := p[0]
			newPerson.Name += fmt.Sprintf("%d", counter)
			counter++
			newData <- p
			time.Sleep(time.Second)
		}
	}()
	http.HandleFunc("/", home)
	fmt.Println("Listening on port 8080")
	http.ListenAndServe(":8080", nil)
}
