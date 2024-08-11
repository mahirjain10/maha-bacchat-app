package types

import (
	"time"

	"github.com/golang-jwt/jwt"
)

type TRegisterUser struct {
	Email     string    `json:"email" bson:"email"`
	Password  string    `json:"password" bson:"password"`
	MobileNo  string    `json:"mobile_no" bson:"mobileNo"`
	Role      string    `json:"role" bson:"role"`
	CreatedAt time.Time `json:"created_at,omitempty" bson:"createdAt"`
	UpdatedAt time.Time `json:"updated_at,omitempty" bson:"updatedAt"`
}

type TLoginUser struct {
	ObjectID       string `json:"_id" bson:"_id"`
	Email          string `json:"email" bson:"email"`
	Password       string `json:"password,omitempty" bson:"-"` // Only for JSON unmarshalling
	HashedPassword string `json:"-" bson:"password"`           // Only for MongoDB storage
}

type OTPVerification struct{
	OTP string `bson:"otp"`
	MobileNo string `json:"mobile_no" bson:"mobile_no"`
	isVerified bool `bson:"is_verified"`
}

type UserAuth struct {
	ObjectID string `json:"-" bson:"_id"`
	Email    string `json:"email" bson:"email"`
	Role     string `json:"role" bson:"role"`
}
type Cookie struct {
	Name     string
	Value    string
	Path     string
	MaxAge   time.Duration
	HttpOnly bool
	Secure   bool
	SameSite string
}

type Profile struct {
	Name      string    `json:"name" bson:"name"`
	StoreName string    `json:"store_name" bson:"storeName"`
	Address   string    `json:"address" bson:"address"`
	UserID    string    `json:"user_id" bson:"userID"`
	CreatedAt time.Time `json:"created_at" bson:"createdAt"`
	UpdatedAt time.Time `json:"updated_at" bson:"updatedAt"`
}
type CreateANewOrderRequest struct {
	ObjectID           string    `json:"_id,omitempty" bson:"_id"`
	CreatorID          string    `json:"-" bson:"creatorId"`
	ProductName        string    `json:"product_name" bson:"productName"`
	DistributorName    string    `json:"distributor_name" bson:"distributorName"`
	BoughtQty          int32     `json:"bought_qty" bson:"boughtQty"`
	MinQty             int32     `json:"min_qty" bson:"minQty"`
	PurchaseQty        int32     `json:"purchase_qty" bson:"purchaseQty"`
	RemainingQty       int32     `json:"remaining_qty" bson:"remainingQty"`
	Mrp                int32     `json:"mrp" bson:"mrp"`
	Cost               int32     `json:"cost" bson:"cost"`
	RequestExpiry      time.Time `json:"request_expiry" bson:"requestExpiry"`
	IsRequestFulfilled bool      `json:"is_request_fulfilled" bson:"isRequestFulfilled"`
	CreatedAt          time.Time `json:"created_at" bson:"createdAt"`
	UpdatedAt          time.Time `json:"updated_at" bson:"updatedAt"`
}

type AddProductDist struct {
	ObjectID      string    `json:"_id,omitempty" bson:"_id,omitempty"`
	DistributorID string    `bson:"distId"`
	ProductName   string    `json:"product_name" bson:"productName"`
	Mrp           float32   `json:"mrp" bson:"mrp"`
	Cost          float32   `json:"cost" bson:"cost"`
	AvailableQty  int32     `json:"avail_qty" bson:"availQty"`
	RemainingQty  int32     `json:"remain_qty" bson:"remainQty"`
	MinQty        int32     `json:"min_qty" bson:"minQty"`
	CreatedAt     time.Time `json:"created_at,omitempty" bson:"createdAt"`
	UpdatedAt     time.Time `json:"updated_at,omitempty" bson:"updatedAt"`
}
type EditProductDist struct {
	ProductID     string    `json:"product_id" bson:"_id"`
	DistributorID string    `bson:"distId"`
	ProductName   string    `json:"product_name" bson:"productName"`
	Mrp           *float32  `json:"mrp,omitempty" bson:"mrp"`
	Cost          *float32  `json:"cost,omitempty" bson:"cost"`
	AvailableQty  *int32    `json:"avail_qty,omitempty" bson:"availQty"`
	RemainingQty  *int32    `json:"remain_qty,omitempty" bson:"remainQty"`
	MinQty        *int32    `json:"min_qty,omitempty" bson:"minQty"`
	CreatedAt     time.Time `json:"created_at,omitempty" bson:"createdAt"`
	UpdatedAt     time.Time `json:"updated_at,omitempty" bson:"updatedAt"`
}
type ProductDist struct{
	ProductID     string    `json:"product_id" bson:"_id"`
	DistributorID string    `bson:"distId"`
	ProductName   string    `bson:"productName"`
	Mrp           *float32  `bson:"mrp"`
	Cost          *float32  `bson:"cost"`
	AvailableQty  *int32    `bson:"availQty"`
	RemainingQty  *int32    `bson:"remainQty"`
	MinQty        *int32    `bson:"minQty"`
	CreatedAt     time.Time `bson:"createdAt"`
	UpdatedAt     time.Time `bson:"updatedAt"`
}
type CustomClaims struct {
	ID string `json:"_id"`
	jwt.StandardClaims
}
