package main

import (
	"encoding/json"
	"net/http"
)

type Product struct {
	Id   int
	Name string
}

func main() {
	http.HandleFunc("/catalog/products", productsHandler)
	http.ListenAndServe(":3333", nil)
}

func productsHandler(w http.ResponseWriter, r *http.Request) {
	p := Product{Id: 11, Name: "Schuhe"}
	p2 := Product{Id: 12, Name: "T-Shirt"}
	products := []Product{p, p2}
	json, _ := json.Marshal(products)
	w.Write(json)
}
