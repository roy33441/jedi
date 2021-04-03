package utils

import (
	"fmt"
	"net/http"
	"strconv"
	"time"

	"dev.azure.com/u8635137/_git/Jedi/backend/core"
	"github.com/gin-gonic/gin"
)

func InvalidParamResponse(context *gin.Context, err error) {
	fmt.Println("Error: " + err.Error())

	context.AbortWithStatusJSON(
		http.StatusBadRequest,
		gin.H{
			"error": "invalid variable",
		},
	)
}

func CheckConvertParamToDate(context *gin.Context, param string, data *time.Time) bool {
	var err error
	const TIME_LAYOUT = "2006-01-02"

	if *data, err = time.Parse(TIME_LAYOUT, param); err != nil {
		InvalidParamResponse(context, err)

		return false
	}

	return true
}

func CheckConvertParamToInt(context *gin.Context, param string, data *int) bool {
	var err error

	if *data, err = strconv.Atoi(param); err != nil {
		InvalidParamResponse(context, err)

		return false
	}

	return true
}

func CheckBodyContentBind(context *gin.Context, data interface{}) bool {
	if err := context.ShouldBind(&data); err != nil {
		InvalidParamResponse(context, err)

		return false
	}

	return true
}

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
