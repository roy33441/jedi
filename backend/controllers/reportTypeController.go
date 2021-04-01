package controllers

import (
	"net/http"

	"dev.azure.com/u8635137/_git/Jedi/backend/models"
	"dev.azure.com/u8635137/_git/Jedi/backend/services"
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

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *ReportTypeController) addReportType(context *gin.Context) {
	var reportType models.ReportType

	if err := context.ShouldBind(&reportType); err != nil {
		context.AbortWithError(
			http.StatusBadRequest,
			err,
		)

		return 
	}

	result, err := controller.reportTypeService.AddReportType(reportType)

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *ReportTypeController) deleteReportType(context *gin.Context) {
	result, err := controller.reportTypeService.DeleteReportType(context.Param("id"))

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *ReportTypeController) updateReportType(context *gin.Context) {
	var reportType models.ReportType

	if err := context.ShouldBind(&reportType); err != nil {
		context.AbortWithError(
			http.StatusBadRequest,
			err,
		)

		return 
	}

	result, err := controller.reportTypeService.UpdateReportType(reportType)

	HandleStandardHTTPRequest(context, result, err)
}