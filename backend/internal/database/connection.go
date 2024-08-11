package database

import (
	"context"
	"os"
	"time"

	"github.com/mahirjain_10/maha-bacchat-app/internal/helpers"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"go.mongodb.org/mongo-driver/mongo/readpref"
)

func ConnectDB(logger *helpers.Logger) (*mongo.Client, error) {
    ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
    defer cancel()

    client, err := mongo.Connect(ctx, options.Client().ApplyURI(os.Getenv("MONGO_URI")))
    if err != nil {
        logger.ErrorLog.Printf("error connecting to database: %v", err)
        return nil, err
    }

    logger.InfoLog.Println("connected to database successfully")

    if err := client.Ping(ctx, readpref.Primary()); err != nil {
        logger.ErrorLog.Printf("error while pinging database: %v", err)
        return nil, err
    }

    logger.InfoLog.Println("connected successfully")
    return client, nil
}

func GetCollection(client *mongo.Client, collectionName string) *mongo.Collection {
    return client.Database("maha-bacchat-app").Collection(collectionName)
}