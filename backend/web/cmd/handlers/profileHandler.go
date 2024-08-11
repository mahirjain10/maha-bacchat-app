package handlers

import (
	"context"
	"net/http"
	"time"

	"github.com/mahirjain_10/maha-bacchat-app/internal/database"
	"github.com/mahirjain_10/maha-bacchat-app/internal/helpers"
	"github.com/mahirjain_10/maha-bacchat-app/internal/types"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

func CreateProfile(logger *helpers.Logger, client *mongo.Client) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
		defer cancel()

		w.Header().Set("Content-Type", "application/json")

		var profile types.Profile
		var user types.TLoginUser

		if err := helpers.DecodeJSON(w, r, &profile); err != nil {
			return
		}

		logger.InfoLog.Printf("profile unmarshalled : %v", profile)

		profilesColl := database.GetCollection(client, "profiles")
		usersColl := database.GetCollection(client, "users")

		// Check if user profile is already created
		objectID, err := primitive.ObjectIDFromHex(profile.UserID)
		if err != nil {
			helpers.EncodeJSON(w, http.StatusInternalServerError, "error while converting string to objectID", nil,nil,false)
			return
		}
		userFilter := bson.D{{Key: "_id", Value: objectID}}
		profileFilter := bson.D{{Key: "userID", Value: profile.UserID}}

		logger.InfoLog.Printf("userFilter => %v", userFilter)
		logger.InfoLog.Printf("type of id %T", profile.UserID)
		logger.InfoLog.Printf("id => %s", profile.UserID)

		err = profilesColl.FindOne(ctx, profileFilter).Decode(&profile)
		if err != mongo.ErrNoDocuments {
			if err == nil {
				logger.InfoLog.Println("user profile already exists")
				helpers.EncodeJSON(w, http.StatusConflict, "user profile already exists", nil,nil,false)
			} else {
				logger.ErrorLog.Printf("error checking profile existence: %v", err)
				helpers.EncodeJSON(w, http.StatusInternalServerError, "internal server error", nil,nil,false)
			}
			return
		}

		// Check if user account exists
		err = usersColl.FindOne(ctx, userFilter).Decode(&user)
		if err != nil {
			if err == mongo.ErrNoDocuments {
				logger.InfoLog.Println("user account not found")
				helpers.EncodeJSON(w, http.StatusNotFound, "user account not found, create a new account", nil,nil,false)
			} else {
				logger.ErrorLog.Printf("error checking user existence: %v", err)
				helpers.EncodeJSON(w, http.StatusInternalServerError, "internal server error", nil,nil,false)
			}
			return
		}

		// Create new profile
		currentTime := time.Now()
		profile.CreatedAt = currentTime
		profile.UpdatedAt = currentTime

		result, err := profilesColl.InsertOne(ctx, profile)
		if err != nil {
			logger.ErrorLog.Printf("error while saving your data: %v", err)
			helpers.EncodeJSON(w, http.StatusBadRequest, "error while saving your data", nil,nil,false)
			return
		}

		responseData := map[string]interface{}{
			"_id":        result.InsertedID,
			"name":       profile.Name,
			"store_name": profile.StoreName,
			"address":    profile.Address,
			"user_id":    profile.UserID,
			"created_at": profile.CreatedAt,
			"updated_at": profile.UpdatedAt,
		}

		helpers.EncodeJSON(w, http.StatusCreated, "user profile created successfully", responseData,nil,true)
	}
}

// func GetUserProfile(logger *helpers.Logger, client *mongo.Client) http.HandlerFunc {
// 	return func(w http.ResponseWriter, r *http.Request) {
// 		ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
// 		defer cancel()

// 		w.Header().Set("Content-Type", "application/json")
// 		var profile types.Profile
// 		if err := helpers.DecodeJSON(w, r, &profile); err != nil {
// 			return
// 		}
// 		profilesColl := database.GetCollection(client, "profiles")

	
// 	}
// }
