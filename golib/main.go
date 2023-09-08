package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"
	"math/rand"
	"github.com/gorilla/mux"
)

type Tasks struct {
	ID       string `json:"id"`
	TaskTime string `json:"task_time"`
	TaskName string `json:"task_name"`
}

var tasks []Tasks

func allTasks() {
	task := Tasks{
		ID:       "1",
		TaskTime: "21:00",
		TaskName: "Task1",
	}
	tasks = append(tasks, task)
	task2 := Tasks{
		ID:       "2",
		TaskTime: "22:00",
		TaskName: "Task2",
	}
	tasks = append(tasks, task2)
	fmt.Println("your tasks are", tasks)
}

func homePage(w http.ResponseWriter, r *http.Request) {
	fmt.Println("I am home")
}
func getTasks(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(tasks)
}
func getTask(w http.ResponseWriter, r *http.Request) {
	taskID := mux.Vars(r)
	flag := false
	for i := 0; i < len(tasks); i++ {
		if taskID["id"] == tasks[i].ID {
			json.NewEncoder(w).Encode(tasks[i])
			flag = true
			break
		}
	}
	if flag == false {
		json.NewEncoder(w).Encode(map[string]string{"status": "Error"})
	}
}
func createTask(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	var task Tasks
	_ = json.NewDecoder(r.Body).Decode(&task)
	task.ID = strconv.Itoa(rand.Intn(1000))
	tasks = append(tasks, task)
	json.NewEncoder(w).Encode(task)
}
func deleteTask(w http.ResponseWriter, r *http.Request) {
}
func updateTask(w http.ResponseWriter, r *http.Request) {
}

func handleRoutes() {
	router := mux.NewRouter()
	router.HandleFunc("/", homePage).Methods(("GET"))
	router.HandleFunc("/gettasks", getTasks).Methods(("GET"))
	router.HandleFunc("/gettask/{id}", getTask).Methods(("GET"))
	router.HandleFunc("/create", createTask).Methods(("POST"))
	router.HandleFunc("/delete/{id}", deleteTask).Methods(("DELETE"))
	router.HandleFunc("/update/{id}", updateTask).Methods(("PUT"))
	log.Fatal(http.ListenAndServe(":8082", router))
}

func main() {
	allTasks()
	fmt.Println("Hello World")
	handleRoutes()
}
