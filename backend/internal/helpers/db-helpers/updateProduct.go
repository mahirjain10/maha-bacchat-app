package dbhelpers

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
	"go.mongodb.org/mongo-driver/mongo/options"
)

func UpdateProduct(w http.ResponseWriter,client *mongo.Client, collectionName string, updateData types.EditProductDist) error {
	collection := database.GetCollection(client, collectionName)

	updateFields := bson.M{}
	productID, err := primitive.ObjectIDFromHex(updateData.ProductID)
	if err != nil {
		return helpers.EncodeJSON(w, http.StatusInternalServerError, "error while converting string to objectID", nil,nil,false)
	}
	if updateData.ProductName != "" {
		updateFields["productName"] = updateData.ProductName
	}
	if updateData.Mrp != nil {
		updateFields["mrp"] = *updateData.Mrp
	}
	if updateData.Cost != nil {
		updateFields["cost"] = *updateData.Cost
	}
	if updateData.AvailableQty != nil {
		updateFields["availQty"] = *updateData.AvailableQty
	}
	if updateData.RemainingQty != nil {
		updateFields["remainQty"] = *updateData.RemainingQty
	}
	if updateData.MinQty != nil {
		updateFields["minQty"] = *updateData.MinQty
	}
	currentTime := time.Now()
	updateFields["updatedAt"] = currentTime

	filter := bson.M{"_id": productID}
	update := bson.M{"$set": updateFields}
	options := options.FindOneAndUpdate().SetReturnDocument(options.After)
	err = collection.FindOneAndUpdate(context.TODO(), filter, update, options).Decode(&updateData)
	if err != nil {
		return err
	}
	return nil
}
