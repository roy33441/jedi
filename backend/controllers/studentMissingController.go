package controllers

import (
	"dev.azure.com/u8635137/_git/Jedi/backend/services"
)

type MissingStudentController struct {
	studentMissingService services.MissingStudentService
}

// func NewMissingStudentController(
// 		router *gin.RouterGroup,
// 		missingStudentService services.MissingStudentService,
// 	) {
// 	controller := MissingStudentController{missingStudentService}
// }
