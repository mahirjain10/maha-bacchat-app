package handlers

import (
	"context"
	"net/http"
	"time"

	"github.com/mahirjain_10/maha-bacchat-app/internal/database"
	"github.com/mahirjain_10/maha-bacchat-app/internal/helpers"
	"github.com/mahirjain_10/maha-bacchat-app/internal/types"
	"github.com/mahirjain_10/maha-bacchat-app/internal/validators"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"golang.org/x/crypto/bcrypt"
)

func RegisterUser(logger *helpers.Logger, client *mongo.Client) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
		defer cancel()
		w.Header().Set("Content-Type", "application/json")
		var user types.TRegisterUser
		//unmarshalling json
		if err := helpers.DecodeJSON(w, r, &user); err != nil {
			return
		}
		validationErr := validators.ValidateUser(logger, user)
		if len(validationErr) != 0 {
			helpers.EncodeJSON(w, http.StatusBadRequest, "validation error", nil, validationErr,false)
			return
		}
		coll := database.GetCollection(client, "users")
		userFilter := bson.D{{Key: "email", Value: user.Email}}

		err := coll.FindOne(ctx, userFilter).Decode(&user)
		logger.InfoLog.Println(user)
		if err != mongo.ErrNoDocuments {
			logger.InfoLog.Println(user)
			helpers.EncodeJSON(w, http.StatusBadRequest, "User already exists", nil, nil,false)
			return
		}

		hashPassword, err := bcrypt.GenerateFromPassword([]byte(user.Password), bcrypt.DefaultCost)

		if err != nil {
			logger.ErrorLog.Printf("error while hashing password : %v", err)
			helpers.EncodeJSON(w, http.StatusInternalServerError, "internal server error", nil, nil,false)
			return
		}
		user.Password = string(hashPassword)
		currentTime := time.Now()
		user.CreatedAt = currentTime
		user.UpdatedAt = currentTime

		result, err := coll.InsertOne(ctx, user)
		if err != nil {
			logger.ErrorLog.Printf("error while saving your data : %v", err)
			helpers.EncodeJSON(w, http.StatusBadRequest, "error while saving your data", nil, nil,false)
			return
		}

		logger.InfoLog.Printf("user : %v", user)
		logger.InfoLog.Printf("result : %s", result)

		//  converting string to objectID
		objectID, ok := result.InsertedID.(primitive.ObjectID)
		if !ok {
			logger.InfoLog.Println("error while asserting objectID")
			helpers.EncodeJSON(w, http.StatusInternalServerError, "internal server error", nil, nil,false)
			return
		}

		token, err := helpers.CreateToken(logger, objectID)
		if err != nil {
			logger.ErrorLog.Printf("error while generating jwt %v", err)
			helpers.EncodeJSON(w, http.StatusInternalServerError, "internal server error", nil, nil,false)
			return
		}

		cookieName := "token"
		cookieValue := token
		cookieAge := 28
		helpers.SetCookie(logger, w, cookieName, cookieValue, cookieAge)

		responseData := map[string]interface{}{
			"_id":        result.InsertedID,
			"email":      user.Email,
			"mobile_no":  user.MobileNo,
			"role":       user.Role,
			"created_at": user.CreatedAt,
			"updated_at": user.UpdatedAt,
		}

		helpers.EncodeJSON(w, http.StatusCreated, "user signed up successfully", responseData, nil,true)
	}
}

func LoginUser(logger *helpers.Logger, client *mongo.Client) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
		defer cancel()
		w.Header().Set("Content-Type", "application/json")
		var user types.TLoginUser
		if err := helpers.DecodeJSON(w, r, &user); err != nil {
			return
		}
		validationErr := validators.ValidateLoginUser(logger, user)
		if len(validationErr) != 0 {
			helpers.EncodeJSON(w, http.StatusBadRequest, "validation error", nil, validationErr,false)
			return
		}
		coll := database.GetCollection(client, "users")
		filter := bson.D{{Key: "email", Value: user.Email}} // Define filter using user.Email
		err := coll.FindOne(ctx, filter).Decode(&user)
		if err == mongo.ErrNoDocuments {
			logger.InfoLog.Printf("user not found %v", err)
			helpers.EncodeJSON(w, http.StatusUnauthorized, "user credential not found", nil, nil,false)
			return
		}
		if err != nil {
			logger.ErrorLog.Fatalf("error occurred while retrieving document : %v", err)
			helpers.EncodeJSON(w, http.StatusInternalServerError, "internal server error", nil, nil,false)
			return
		}
		err = bcrypt.CompareHashAndPassword([]byte(user.HashedPassword), []byte(user.Password))
		if err != nil {
			logger.InfoLog.Printf("error while comparing password %v", err)
			helpers.EncodeJSON(w, http.StatusUnauthorized, "password mismatch,please enter correct password", nil, nil,false)
			return
		}

		logger.InfoLog.Printf("user object type : %T", user.ObjectID)
		logger.InfoLog.Printf("user  object : %v", user.ObjectID)

		// the user.ObjectID is string
		// we are convertting string to primitive.ObjectID
		objectID, err := primitive.ObjectIDFromHex(user.ObjectID)
		if err != nil {
			logger.InfoLog.Printf("error while converting hex to objectID %v", err)
		}
		token, err := helpers.CreateToken(logger, objectID)
		if err != nil {
			logger.ErrorLog.Printf("error while generating jwt %v", err)
			helpers.EncodeJSON(w, http.StatusInternalServerError, "internal server error", nil, nil,false)
			return
		}
		cookieName := "token"
		cookieValue := token
		cookieAge := 28

		helpers.SetCookie(logger, w, cookieName, cookieValue, cookieAge)
		helpers.EncodeJSON(w, http.StatusOK, "login successfull", nil, nil,true)
	}
}

func SendOtp(logger *helpers.Logger, client *mongo.Client) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
		defer cancel()
		w.Header().Set("Content-Type", "application/json")
		var otp types.OTPVerification
		if err := helpers.DecodeJSON(w, r, &otp); err != nil {
			return
		}
}}
