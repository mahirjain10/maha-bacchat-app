package middlewares

import (
	"context"
	"net/http"

	"github.com/mahirjain_10/maha-bacchat-app/internal/database"
	"github.com/mahirjain_10/maha-bacchat-app/internal/helpers"
	"github.com/mahirjain_10/maha-bacchat-app/internal/types"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)


const jwtToken = "token"

type ContextKey string
const userIDKey ContextKey = "userID"
    
func Auth(client *mongo.Client, logger *helpers.Logger) func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			cookie, err := helpers.GetCookie(logger, w, r, jwtToken)
			if err != nil {
				logger.InfoLog.Printf("error while fetching cookie: %v", err)
				helpers.EncodeJSON(w, http.StatusBadRequest, "error while fetching cookie", nil,nil,false)
				return
			}

			token, err := helpers.VerifyToken(cookie.Value)
			if err != nil {
				logger.InfoLog.Printf("error while verifying jwt token: %v", err)
				helpers.EncodeJSON(w, http.StatusBadRequest, "error verifying jwt token", nil,nil,false)
				return
			}

			var userAuth types.UserAuth
			coll := database.GetCollection(client, "users")

			objectID, err := primitive.ObjectIDFromHex(token.ID)
			if err != nil {
				logger.InfoLog.Printf("error while converting string to ObjectID: %v", err)
				helpers.EncodeJSON(w, http.StatusInternalServerError, "error while converting string to ObjectID", nil,nil,false)
				return
			}

			filter := bson.D{{Key: "_id", Value: objectID}}
			err = coll.FindOne(context.TODO(), filter).Decode(&userAuth)
			if err == mongo.ErrNoDocuments {
				logger.InfoLog.Println("user not found")
				helpers.EncodeJSON(w, http.StatusNotFound, "user not found", nil,nil,false)
				return
			}
			if err != nil {
				logger.InfoLog.Printf("error while retrieving user document: %v", err)
				helpers.EncodeJSON(w, http.StatusInternalServerError, "internal server error", nil,nil,false)
				return
			}

			// Add log to confirm the user ID
			logger.InfoLog.Printf("Setting userID in context: %v is of type %T", userAuth,userAuth)
			
			// userAuthDetails, err := json.Marshal(userAuth)
			// if err != nil {
			// 	helpers.EncodeJSON(w,http.StatusInternalServerError,"failed to send response",nil,nil)
			// 	return
			// }
			// helpers.SetCookie(logger,w,"user",string(userAuthDetails),28)
			ctx := context.WithValue(r.Context(), userIDKey, userAuth.ObjectID)
			r = r.WithContext(ctx)
			next.ServeHTTP(w, r)
		})
	}
}
