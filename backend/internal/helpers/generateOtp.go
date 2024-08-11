package helpers

import (
	"crypto/rand"
	"fmt"
	"math/big"
)

const (
	length=6
)
func GenerateOTP() (string, error) {
	// Define the range for the random number
	min := big.NewInt(int64(pow(10, length-1)))
	max := big.NewInt(int64(pow(10, length)))

	// Generate a random number within the range
	randomNum, err := rand.Int(rand.Reader, max.Sub(max, min))
	if err != nil {
		return "", err
	}

	// Pad the number with leading zeros if necessary
	otp := fmt.Sprintf("%0"+fmt.Sprint(length)+"d", randomNum.Int64()+min.Int64())
	fmt.Println(otp)
	return otp, nil
}

func pow(base, exponent int) int {
	result := 1
	for i := 0; i < exponent; i++ {
		result *= base
	}
	return result
}


