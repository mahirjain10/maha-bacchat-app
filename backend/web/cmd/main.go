package main

import (
	"context"
	"log"
	"net/http"
	"os"

	"github.com/gorilla/mux"
	"github.com/mahirjain_10/maha-bacchat-app/internal/database"
	"github.com/mahirjain_10/maha-bacchat-app/internal/helpers"
	"github.com/mahirjain_10/maha-bacchat-app/web/cmd/handlers"
	"github.com/mahirjain_10/maha-bacchat-app/web/cmd/middlewares"
)

func main() {
	// Generate OTP (if necessary for startup)
	helpers.GenerateOTP()

	// Initialize loggers
	infoLog := log.New(os.Stdout, "INFO\t", log.Ldate|log.Ltime)
	errorLog := log.New(os.Stderr, "ERROR\t", log.Ldate|log.Ltime|log.Lshortfile)
	logger := helpers.InitializeLogger(infoLog, errorLog)

	// Initialize environment variables
	helpers.IntializeEnv(logger)

	// Connect to the database
	client, err := database.ConnectDB(logger)
	if err != nil {
		logger.ErrorLog.Fatalf("Failed to connect to database: %v", err)
	}
	defer func() {
		if err := client.Disconnect(context.Background()); err != nil {
			logger.ErrorLog.Printf("Error disconnecting from database: %v", err)
		}
	}()

	// Initialize router
	r := mux.NewRouter()

	// v := govalidator.New()
	// Define routes
	r.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		logger.InfoLog.Println("recieved");
		w.Write([]byte("hello world"))
	}).Methods("GET")

	r.HandleFunc("/register", handlers.RegisterUser(logger, client)).Methods("POST")
	r.HandleFunc("/login", handlers.LoginUser(logger, client)).Methods("POST")
	r.HandleFunc("/create-profile", handlers.CreateProfile(logger, client)).Methods("POST")
	// Apply authentication middleware to protected routes
	authMiddleware := middlewares.Auth(client, logger)
	r.Handle("/add-product-distributor", authMiddleware(http.HandlerFunc(handlers.AddProductDist(logger, client)))).Methods("POST")
	r.Handle("/edit-product-distributor",authMiddleware(http.HandlerFunc(handlers.EditProductDist(logger, client)))).Methods("PATCH")
	r.Handle("/get-product-by-id-distributor",authMiddleware(http.HandlerFunc(handlers.GetProductbyID(logger, client)))).Methods("GET")
	r.Handle("/get-all-product-distributor",authMiddleware(http.HandlerFunc(handlers.GetAllProduct(logger, client)))).Methods("GET")

	// Start the server
	logger.InfoLog.Printf("Server running on port %s", ":8000")
	err = http.ListenAndServe(":8000", r)
	if err != nil {
		logger.ErrorLog.Fatal(err)
	}
}

// main
// main