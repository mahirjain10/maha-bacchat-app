package handlers

import (
	"context"
	"errors"
	"fmt"
	"net/http"
	"time"

	"github.com/mahirjain_10/maha-bacchat-app/internal/database"
	"github.com/mahirjain_10/maha-bacchat-app/internal/helpers"
	dbhelpers "github.com/mahirjain_10/maha-bacchat-app/internal/helpers/db-helpers"
	"github.com/mahirjain_10/maha-bacchat-app/internal/types"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

const PRODUCT_COLL = "products"

func AddProductDist(logger *helpers.Logger, client *mongo.Client) http.HandlerFunc {
	// we need add feature of authorized and we had already authenticated
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
		defer cancel()
		w.Header().Set("Content-Type", "application/json")
		var addProductDist types.AddProductDist
		if err := helpers.DecodeJSON(w, r, &addProductDist); err != nil {
			return
		}

		// Add log to check context value
		logger.InfoLog.Printf("Context before fetching userIDKey: %v", r.Context())

		// saving userID
		user := r.Context().Value(userIDKey)
		logger.InfoLog.Println("user : ", user)

		// collection
		coll := database.GetCollection(client, PRODUCT_COLL)
		// Saving current time with built-in func
		addProductDist.DistributorID = user.(string)
		currentTime := time.Now()
		addProductDist.CreatedAt = currentTime
		addProductDist.UpdatedAt = currentTime

		// Inserting data
		result, err := coll.InsertOne(ctx, addProductDist)
		if err != nil {
			logger.ErrorLog.Printf("error while saving distributor's product : %v", err)
			helpers.EncodeJSON(w, http.StatusBadRequest, "error while saving distributor's product details", nil, nil,false)
			return
		}
		// Response object initailization
		responseData := map[string]interface{}{
			"product_id":     result.InsertedID,
			"distributor_id": addProductDist.DistributorID,
			"product_name":   addProductDist.ProductName,
			"mrp":            addProductDist.Mrp,
			"cost":           addProductDist.Cost,
			"available_qty":  addProductDist.AvailableQty,
			"remaining_qty":  addProductDist.RemainingQty,
			"min_qty":        addProductDist.MinQty,
			"created_at":     addProductDist.CreatedAt,
			"updated_at":     addProductDist.UpdatedAt,
		}
		helpers.EncodeJSON(w, http.StatusCreated, "product created successfully", responseData, nil,true)
	})
}

func EditProductDist(logger *helpers.Logger, client *mongo.Client) http.HandlerFunc {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		_, cancel := context.WithTimeout(context.Background(), 10*time.Second)
		defer cancel()
		w.Header().Set("Content-Type", "application/json")
		var product types.EditProductDist
		if err := helpers.DecodeJSON(w, r, &product); err != nil {
			return
		}
		// saving userID
		user := r.Context().Value(userIDKey)
		logger.InfoLog.Println("user : ", user)

		logger.InfoLog.Printf("product %v", product)
		err := dbhelpers.UpdateProduct(w, client, PRODUCT_COLL, product)
		if err != nil {
			if errors.Is(err, mongo.ErrNoDocuments) {
				logger.ErrorLog.Printf("no document found with respective productID : %v", err)
				helpers.EncodeJSON(w, http.StatusBadRequest, "no document found with respective productID", nil, nil,false)
				return
			}
			logger.ErrorLog.Printf("error while saving updating distributor's product : %v", err)
			helpers.EncodeJSON(w, http.StatusBadRequest, "error while updating distributor's product details", nil, nil,false)
			return
		}
		logger.InfoLog.Println("product updated successfully")
		responseData := map[string]interface{}{
			"product_id":     product.ProductID,
			"distributor_id": product.DistributorID,
			"product_name":   product.ProductName,
			"mrp":            product.Mrp,
			"cost":           product.Cost,
			"available_qty":  product.AvailableQty,
			"remaining_qty":  product.RemainingQty,
			"min_qty":        product.MinQty,
			"created_at":     product.CreatedAt,
			"updated_at":     product.UpdatedAt,
		}
		helpers.EncodeJSON(w, http.StatusOK, "distributor's product updated successfully", responseData, nil,true)
	})
}

func GetProductbyID(logger *helpers.Logger, client *mongo.Client) http.HandlerFunc {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
		defer cancel()
		w.Header().Set("Content-Type", "application/json")
		var product types.ProductDist
		if err := helpers.DecodeJSON(w, r, &product); err != nil {
			return
		}
		user := r.Context().Value(userIDKey)
		logger.InfoLog.Println("user : ", user)

		productID, err := primitive.ObjectIDFromHex(product.ProductID)
		if err != nil {
			logger.ErrorLog.Printf("error while converting string to objectID %v :", err)
			helpers.EncodeJSON(w, http.StatusInternalServerError, "internal server error", nil, nil,false)
			return
		}
		coll := database.GetCollection(client, PRODUCT_COLL)
		filter := bson.M{"_id": productID}

		err = coll.FindOne(ctx, filter).Decode(&product)
		if err != nil {
			if errors.Is(err, mongo.ErrNoDocuments) {
				logger.InfoLog.Printf("no document found with the the respective productID : %v", err)
				helpers.EncodeJSON(w, http.StatusNotFound, "product not found", nil, nil,false)
				return
			}
			logger.ErrorLog.Printf("error while finding the product : %v", err)
			helpers.EncodeJSON(w, http.StatusInternalServerError, "error while finding the product", nil, nil,false)
			return
		}
		logger.InfoLog.Println("product found successfully")
		responseData := map[string]interface{}{
			"product_id":     product.ProductID,
			"distributor_id": product.DistributorID,
			"product_name":   product.ProductName,
			"mrp":            product.Mrp,
			"cost":           product.Cost,
			"available_qty":  product.AvailableQty,
			"remaining_qty":  product.RemainingQty,
			"min_qty":        product.MinQty,
			"created_at":     product.CreatedAt,
			"updated_at":     product.UpdatedAt,
		}

		helpers.EncodeJSON(w, http.StatusOK, "products fetched successfully", responseData, nil,false)

	})
}

func GetAllProduct(logger *helpers.Logger, client *mongo.Client) http.HandlerFunc {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
		defer cancel()
		w.Header().Set("Content-Type", "application/json")
		coll := database.GetCollection(client, PRODUCT_COLL)
		userID := r.Context().Value(userIDKey)
		distID, ok := userID.(string)
		if !ok {
			logger.ErrorLog.Println("userID is not of type string")
			helpers.EncodeJSON(w, http.StatusInternalServerError, "internal server error", nil, nil,false)
			return
		}
		logger.InfoLog.Printf("distID %T : ", distID)
		filter := bson.M{"distId": distID}
		cursor, err := coll.Find(ctx, filter)
		if err != nil {
			logger.ErrorLog.Printf("error while retrieving document %v :", err)
			helpers.EncodeJSON(w, http.StatusInternalServerError, "internal server error", nil, nil,false)
			return
		}
		var results []types.ProductDist
		if err = cursor.All(context.TODO(), &results); err != nil {
			logger.ErrorLog.Printf("error while proccessing documents : %v", err)
			helpers.EncodeJSON(w, http.StatusInternalServerError, "internal server error", nil, nil,false)
		}
		for _, result := range results {
			res, _ := bson.MarshalExtJSON(result, false, false)
			fmt.Println(string(res))
		}
		data := make([]map[string]interface{}, len(results))
		logger.InfoLog.Printf("result's length : %v", results)
		for i, product := range results {
			data[i] = map[string]interface{}{
				"product_id":     product.ProductID,
				"distributor_id": product.DistributorID,
				"product_name":   product.ProductName,
				"mrp":            product.Mrp,
				"cost":           product.Cost,
				"available_qty":  product.AvailableQty,
				"remaining_qty":  product.RemainingQty,
				"min_qty":        product.MinQty,
				"created_at":     product.CreatedAt,
				"updated_at":     product.UpdatedAt,
			}
		}

		// Prepare the response
		response := map[string]interface{}{
			"products": data,
		}

		helpers.EncodeJSON(w, http.StatusOK, "products fetched successfully", response, nil,true)
	})
}
