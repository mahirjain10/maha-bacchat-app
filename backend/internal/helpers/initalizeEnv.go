package helpers

import (
	"github.com/joho/godotenv"
)

func IntializeEnv(logger *Logger) {

	err := godotenv.Load("./../../.env")
	if err !=nil{
		logger.ErrorLog.Fatalf("Error loading .env file : %s",err)
	}

}