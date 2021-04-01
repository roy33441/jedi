package controllers

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func HandleStandardHTTPRequest(context *gin.Context, data interface{}, err error) {
	if err != nil {
		context.AbortWithError(http.StatusInternalServerError, err)

		return 
	}

	context.JSON(
		http.StatusOK,
		data,
	)
}