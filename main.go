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

		json.NewEncoder(w).Encode("function run success")
	})
	log.Println("Application up..")
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Println("Error while creating server : ", err)
	}
}
