package helpers

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/mahirjain_10/maha-bacchat-app/internal/types"
)

func EncodeJSON(w http.ResponseWriter, status int, message string, data map[string]interface{},errors map[string]string,success bool) error {
    
    // Intialize json response using response struct
    jsonResponse := types.Response{
        Status:  status,
        Message: message,
        Data:    data,
        Errors: errors,
        Success: success,
    }

    w.WriteHeader(status) 
    err := json.NewEncoder(w).Encode(jsonResponse)
    // Return error if failed to encode response
    if err != nil {
        return fmt.Errorf("failed to encode response: %v", err)
    }
    // Return if the error is nill
    return nil
}


func DecodeJSON(w http.ResponseWriter,r *http.Request,data interface{}) error {
    // Decode JSON from request body into the provided data structure
    err := json.NewDecoder(r.Body).Decode(data)
    if err != nil {
        // Log error
        log.Printf("encountered error while decoding json: %v", err)
        
        // Determine the appropriate response based on the error type
        statusCode := http.StatusInternalServerError
        errorMessage := "internal server error"

        // Check if the error is due to malformed JSON or invalid data
        if _, ok := err.(*json.SyntaxError); ok || err.Error() == "unexpected EOF" {
            statusCode = http.StatusBadRequest
            errorMessage = "malformed or empty JSON request body"
        }

        // Send response with appropriate status code and error message
        if err := EncodeJSON(w, statusCode, errorMessage, nil,nil,false); err != nil {
            // Handle error if sending response fails
            log.Printf("failed to send response: %v", err)
            http.Error(w, "Failed to send response", http.StatusInternalServerError)
            return err
        }
        return err
    }
    defer r.Body.Close()
    return nil
}
