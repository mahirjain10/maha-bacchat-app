package handlers

import (
	"github.com/mahirjain_10/maha-bacchat-app/web/cmd/middlewares"
)

// Define a custom type for context keys
// type contextKey string
const userIDKey middlewares.ContextKey = "userID"


// func CreateANewOrderRequest(logger *helpers.Logger, client *mongo.Client) http.HandlerFunc {
// 	return func(w http.ResponseWriter, r *http.Request) {
// 		ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
// 		defer cancel()
// 		w.Header().Set("Content-Type", "application/json")
// 		var canor types.CreateANewOrderRequest
// 		if err := helpers.DecodeJSON(w, r, &canor); err != nil {
// 			return
// 		}
// 		creatorID := r.Context().Value(userIDKey)
// 		if creatorID == nil {
// 			logger.InfoLog.Printf("no creatorID found")
// 			helpers.EncodeJSON(w,http.StatusInternalServerError,"internal server error",nil)
// 			return
// 			// return primitive.NilObjectID, errors.New("user ID not found in context")
// 		}
// 		orderAndReqColl := database.GetCollection(client,"order-and-request")
// 		result , err := orderAndReqColl.InsertOne(ctx,canor)
// 		if err != nil {
// 			logger.ErrorLog.Printf("error while saving your data : %v", err)
// 			helpers.EncodeJSON(w, http.StatusBadRequest, "error while saving your data", nil)
// 			return
// 		}

// 		responseData := map[string]interface{}{
// 			"_id":            result.InsertedID,
// 			"creator_id":     creatorID,
// 			"product_name":   canor.ProductName,
// 			"distributor_name": user.IsDistributor,
// 			"is_wholesaler":  user.IsWholesaler,
// 			"is_reseller":    user.IsReseller,
// 			"is_retailer":    user.IsRetailer,
// 			"created_at":     user.CreatedAt,
// 			"updated_at":     user.UpdatedAt,
// 		}

// 	}
// }

