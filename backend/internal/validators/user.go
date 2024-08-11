package validators

import (
	"github.com/mahirjain_10/maha-bacchat-app/internal/helpers"
	"github.com/mahirjain_10/maha-bacchat-app/internal/types"
	"github.com/rezakhademix/govalidator"
	validator "github.com/rezakhademix/govalidator/v2"
)

func ValidateUser(logger *helpers.Logger, user types.TRegisterUser) govalidator.Err {
	//Intialize validator
	v := validator.New()

	// Validation rules
	v.RequiredString(user.Email, "email", "email is required").
		Email(user.Email, "email", "invalid email address").
		RequiredString(user.Password, "password", "password is required").
		MinString(user.Password, 8, "password", "password should be greater or equal to 8").
		MaxString(user.Password, 10, "password", "password should not exceed 10 charachters").
		RequiredString(user.MobileNo, "mobile_no", "mobile number is required").
		MaxString(user.MobileNo, 10, "mobile_no", "mobile number should be 10 charachter long").
		RequiredString(user.Role, "role", "role is required").
		CustomRule(validator.In(user.Role, "distributor", "retailer", "wholesaler", "reseller"), "role", "select a valid role")

	// Log validation errors
	logger.ErrorLog.Printf("errors : %v", v.Errors())

	// Return errors
	return v.Errors()
}

func ValidateLoginUser(logger *helpers.Logger, user types.TLoginUser) govalidator.Err {
	//Intialize validator
	v := validator.New()

	// Validation rules
	v.RequiredString(user.Email, "email", "email is required").
		Email(user.Email, "email", "invalid email address").
		RequiredString(user.Password, "password", "password is required").
		MinString(user.Password, 8, "password", "password should be greater or equal to 8").
		MaxString(user.Password, 10, "password", "password should not exceed 10 charachters")

	// Log validation errors
	logger.ErrorLog.Printf("errors : %v", v.Errors())
	
	// Return errors
	return v.Errors()
}

func ValidateMobileNo(logger *helpers.Logger, otp types.OTPVerification) govalidator.Err {
	v := validator.New()

	v.RequiredString(otp.MobileNo, "mobile_no", "mobile number is required").
	MaxString(otp.MobileNo, 10, "mobile_no", "mobile number should be 10 charachter long")

	logger.ErrorLog.Printf("errors : %v", v.Errors())

	return v.Errors()
}