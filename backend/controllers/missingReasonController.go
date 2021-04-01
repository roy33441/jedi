package controllers

import (
	"fmt"
	"net/http"

	"dev.azure.com/u8635137/_git/Jedi/backend/models"
	"dev.azure.com/u8635137/_git/Jedi/backend/services"
	"github.com/gin-gonic/gin"
)

type MissingReasonController struct {
	missingReasonService services.MissingReasonService
}

func NewMissingReasonController(
	router *gin.RouterGroup, 
	missingReasonService services.MissingReasonService) {
		controller := MissingReasonController{missingReasonService}

		router.GET("/", controller.getAll)
		router.POST("/", controller.addMissingReason)
		router.DELETE("/:id", controller.deleteMissingReason)
		router.PUT("/", controller.updateMissingReason)
}

func (controller *MissingReasonController) getAll(context *gin.Context) {
	result, err := controller.missingReasonService.GetAll()

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *MissingReasonController) addMissingReason(context *gin.Context) {
	var missingReason models.MissingReason

	if err := context.ShouldBind(&missingReason); err != nil {
		fmt.Println("Error: " + err.Error())

		context.AbortWithStatusJSON(
			http.StatusBadRequest,
			gin.H{
				"error": "invalid variable",
			},
		)

		return 
	}

	result, err := controller.missingReasonService.AddMissingReason(missingReason)

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *MissingReasonController) deleteMissingReason(context *gin.Context) {
	result, err := controller.missingReasonService.DeleteMissingReason(context.Param("id"))

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *MissingReasonController) updateMissingReason(context *gin.Context) {
	var missingReason models.MissingReason

	if err := context.ShouldBind(&missingReason); err != nil {
		fmt.Println("Error: " + err.Error())

		context.AbortWithStatusJSON(
			http.StatusBadRequest,
			gin.H{
				"error": "invalid variable",
			},
		)

		return 
	}

	result, err := controller.missingReasonService.UpdateMissingReason(missingReason)

	HandleStandardHTTPRequest(context, result, err)
}