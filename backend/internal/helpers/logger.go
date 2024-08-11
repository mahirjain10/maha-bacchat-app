package helpers

import (
	"log"
)

type Logger struct {
	InfoLog  *log.Logger
	ErrorLog *log.Logger
}

// InitializeLogger initializes the logger with the provided loggers.
func InitializeLogger(infoLog, errorLog *log.Logger) *Logger {
	return &Logger{
		InfoLog:  infoLog,
		ErrorLog: errorLog,
	}
}
