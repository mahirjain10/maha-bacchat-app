package helpers

import (
	"errors"
	"net/http"
)

func SetCookie(logger *Logger,w http.ResponseWriter,name string,value string,age int) {
	logger.InfoLog.Println("cookie func")
    cookie := http.Cookie{
        Name:     name,
        Value:    value,
        Path:     "/",
        MaxAge:   age,
        HttpOnly: true,
        Secure:   true,
        SameSite: http.SameSiteLaxMode,
    }
	http.SetCookie(w,&cookie)
	logger.InfoLog.Printf("set-cookie successful")
}

func GetCookie(logger *Logger,w http.ResponseWriter,r *http.Request,name string)(cookie *http.Cookie,err error){
    getCookie, err := r.Cookie(name)
    if err != nil {
        switch {
        case errors.Is(err, http.ErrNoCookie):
            logger.InfoLog.Printf("cookie not found %v :",err)
            EncodeJSON(w,http.StatusUnauthorized,"cookie not found",nil,nil,false)
            return nil,err
        default:
            logger.InfoLog.Printf("error while retrieving cookie : %v",err)
            EncodeJSON(w,http.StatusInternalServerError,"internal server error",nil,nil,false)
            return nil ,err
        }
    }
    logger.InfoLog.Println("cookie retrieved successfully")
    return getCookie,nil
}