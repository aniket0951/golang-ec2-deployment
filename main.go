package main

import (
	"encoding/json"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Header().Add("Content-Type", "application/json")

		json.NewEncoder(w).Encode("function run success 200cr")
	})
	log.Println("Application up..")
	err := http.ListenAndServe(":9090", nil)
	if err != nil {
		log.Println("Error while creating server : ", err)
	}
}
