package controllers

import (
	"dev.azure.com/u8635137/_git/Jedi/backend/models"
	"dev.azure.com/u8635137/_git/Jedi/backend/services"
	"dev.azure.com/u8635137/_git/Jedi/backend/utils"
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

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *MissingReasonController) addMissingReason(context *gin.Context) {
	var missingReason models.MissingReason

	if !utils.CheckBodyContentBind(context, &missingReason) {
		return
	}

	result, err := controller.missingReasonService.AddMissingReason(missingReason)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *MissingReasonController) deleteMissingReason(context *gin.Context) {
	id := new(int)

	if !utils.CheckConvertParamToInt(context, context.Param("id"), id) {
		return
	}

	result, err := controller.missingReasonService.DeleteMissingReason(*id)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *MissingReasonController) updateMissingReason(context *gin.Context) {
	var missingReason models.MissingReason

	if !utils.CheckBodyContentBind(context, &missingReason) {
		return 
	}

	result, err := controller.missingReasonService.UpdateMissingReason(missingReason)

	utils.HandleStandardHTTPRequest(context, result, err)
}