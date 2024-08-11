package helpers

import (
	"os"
	"time"

	"github.com/golang-jwt/jwt"
	"github.com/mahirjain_10/maha-bacchat-app/internal/types"
	"go.mongodb.org/mongo-driver/bson/primitive"
)



func CreateToken(logger *Logger,objID primitive.ObjectID) (string, error) {
	token := jwt.NewWithClaims(jwt.SigningMethodHS256,
		jwt.MapClaims{
			"_id": objID,
			"exp": time.Now().Add(time.Minute * 30).Unix(),
		})

	tokenString, err := token.SignedString([]byte(os.Getenv("JWT_SECRET_KEY")))
	logger.InfoLog.Printf("%T",os.Getenv("JWT_SECRET_KEY"))
	if err != nil {
		logger.ErrorLog.Printf("error while generating jwt %v",err)
		return "", err
	}
	logger.InfoLog.Println("jwt token generated successfully")
	return tokenString, nil
}

func VerifyToken(tokenString string) (*types.CustomClaims, error) {
    claims := &types.CustomClaims{}

    // Parse the token with the secret key and custom claims
    token, err := jwt.ParseWithClaims(tokenString, claims, func(token *jwt.Token) (interface{}, error) {
        return []byte(os.Getenv("JWT_SECRET_KEY")), nil
    })

    // Check for verification errors
    if err != nil {
        return nil, err
    }

    // Check if the token is valid
    if !token.Valid {
        return nil, jwt.ErrInvalidKey
    }

    // Return the verified claims
    return claims, nil
}