package controllers

import (
	"fmt"
	"net/http"

	"dev.azure.com/u8635137/_git/Jedi/backend/core"
	"github.com/gin-gonic/gin"
)

func HandleStandardHTTPRequest(context *gin.Context, data interface{}, err error) {
	if err != nil {
		fmt.Println("Error: " + err.Error())

		massage := ""
		status := http.StatusInternalServerError

		if customError, ok := err.(*core.StudentAlreadyArrivedError); ok {
			status = customError.Status()
			massage = err.Error()
		} else if customError, ok := err.(*core.UnauthorizedInCourseError); ok {
			status = customError.Status()
			massage = err.Error()
		} else {
			massage = "error processing the request"
		}

		context.AbortWithStatusJSON(
			status,
			gin.H{
				"error": massage,
			},
		)

		return 
	}

	context.JSON(
		http.StatusOK,
		data,
	)
}