package controllers

import (
	"dev.azure.com/u8635137/_git/Jedi/backend/models"
	"dev.azure.com/u8635137/_git/Jedi/backend/services"
	"dev.azure.com/u8635137/_git/Jedi/backend/utils"
	"github.com/gin-gonic/gin"
)

type ReportTypeController struct {
	reportTypeService services.ReportTypeService
}

func NewReportTypeController(
	router *gin.RouterGroup, 
	reportTypeService services.ReportTypeService) {
		controller := ReportTypeController{reportTypeService}

		router.GET("/", controller.getAll)
		router.POST("/", controller.addReportType)
		router.DELETE("/:id", controller.deleteReportType)
		router.PUT("/", controller.updateReportType)
}

func (controller *ReportTypeController) getAll(context *gin.Context) {
	result, err := controller.reportTypeService.GetAll()

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *ReportTypeController) addReportType(context *gin.Context) {
	var reportType models.ReportType

	if !utils.CheckBodyContentBind(context, &reportType) {
		return
	}

	result, err := controller.reportTypeService.AddReportType(reportType)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *ReportTypeController) deleteReportType(context *gin.Context) {
	id := new(int)

	if !utils.CheckConvertParamToInt(context, context.Param("id"), id) {
		return
	}

	result, err := controller.reportTypeService.DeleteReportType(*id)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *ReportTypeController) updateReportType(context *gin.Context) {
	var reportType models.ReportType

	if !utils.CheckBodyContentBind(context, &reportType) {
		return 
	}

	result, err := controller.reportTypeService.UpdateReportType(reportType)

	utils.HandleStandardHTTPRequest(context, result, err)
}