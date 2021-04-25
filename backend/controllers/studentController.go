package controllers

import (
	"time"

	"dev.azure.com/u8635137/_git/Jedi/backend/models"
	"dev.azure.com/u8635137/_git/Jedi/backend/services"
	"dev.azure.com/u8635137/_git/Jedi/backend/utils"
	"github.com/gin-gonic/gin"
)

type StudentController struct {
	studentService        services.StudentService
	studentReportService  services.StudentReportService
	missingStudentService services.MissingStudentService
}

func NewStudentController(
	router *gin.RouterGroup,
	studentService services.StudentService,
	studentReportService services.StudentReportService,
	missingStudentService services.MissingStudentService) {
	controller := StudentController{
		studentService, studentReportService, missingStudentService,
	}

	router.GET("/", controller.getAll)
	router.GET("/studentId/:id/reportTypes/:day", controller.getStudentReportDay)
	router.GET("/course/:courseId", controller.getByCourse)
	router.GET("/card/:cardId", controller.getByCardId)
	router.GET("/courseId/:courseId/missings/:day", controller.getMissingStudents)

	router.DELETE("/:id", controller.deleteStudent)

	router.POST("/", controller.addStudent)

	router.PUT("/", controller.updateStudent)
	router.PUT("/studentId/:id/reportTypes/:day", controller.saveStudentReportDay)
	router.PUT("/studentId/:id/missings/:day", controller.reportStudentMissingReason)

	router.PATCH("/studentId/:id/missings/:day/cancel", controller.removeReportStudentMissingReason)
	router.PATCH("/card/:cardId/arrived/course/:courseId", controller.updateStudentArrived)
	router.PATCH("/card/:cardId/left/course/:courseId", controller.updateStudentLeft)
	router.PATCH("/exit", controller.reportStudentsExit)
}

func (controller *StudentController) getMissingStudents(context *gin.Context) {
	day := new(time.Time)
	courseId := new(int)

	if !utils.CheckConvertParamToDate(context, context.Param("day"), day) {
		return
	}

	if !utils.CheckConvertParamToInt(context, context.Param("courseId"), courseId) {
		return
	}

	missingStudents, err := controller.missingStudentService.GetMissingAtDate(*day, *courseId)

	utils.HandleStandardHTTPRequest(context, missingStudents, err)
}

func (controller *StudentController) saveStudentReportDay(context *gin.Context) {
	var reportTypeIds []int

	studentId := new(int)
	day := new(time.Time)

	if !utils.CheckBodyContentBind(context, &reportTypeIds) {
		return
	}

	if !utils.CheckConvertParamToInt(context, context.Param("id"), studentId) {
		return
	}

	if !utils.CheckConvertParamToDate(context, context.Param("day"), day) {
		return
	}

	result, err := controller.studentReportService.AddStudentReportDay(
		*studentId, *day, reportTypeIds,
	)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) reportStudentMissingReason(context *gin.Context) {
	id := new(int)
	day := new(time.Time)
	var missingReason models.MissingReason

	if !utils.CheckConvertParamToInt(context, context.Param("id"), id) {
		return
	}

	if !utils.CheckConvertParamToDate(context, context.Param("day"), day) {
		return
	}

	if !utils.CheckBodyContentBind(context, &missingReason) {
		return
	}

	result, err := controller.missingStudentService.ReportStudentMissingReason(
		*id, *day, &missingReason,
	)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) removeReportStudentMissingReason(context *gin.Context) {
	id := new(int)
	day := new(time.Time)

	if !utils.CheckConvertParamToInt(context, context.Param("id"), id) {
		return
	}

	if !utils.CheckConvertParamToDate(context, context.Param("day"), day) {
		return
	}

	result, err := controller.missingStudentService.RemoveReportStudentMissingReason(
		*id, *day,
	)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) getStudentReportDay(context *gin.Context) {
	id := new(int)
	day := new(time.Time)

	if !utils.CheckConvertParamToInt(context, context.Param("id"), id) {
		return
	}

	if !utils.CheckConvertParamToDate(context, context.Param("day"), day) {
		return
	}

	result, err := controller.studentReportService.GetStudentReportDay(
		*id, *day,
	)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) getAll(context *gin.Context) {
	result, err := controller.studentService.GetAll()

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) addStudent(context *gin.Context) {
	var student models.Student

	if !utils.CheckBodyContentBind(context, &student) {
		return
	}

	result, err := controller.studentService.AddStudent(student)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) deleteStudent(context *gin.Context) {
	id := new(int)

	if !utils.CheckConvertParamToInt(context, context.Param("id"), id) {
		return
	}

	result, err := controller.studentService.DeleteStudent(*id)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) updateStudent(context *gin.Context) {
	var student models.Student

	if !utils.CheckBodyContentBind(context, &student) {
		return
	}

	result, err := controller.studentService.UpdateStudent(student)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) getByCardId(context *gin.Context) {
	id := new(int)

	if !utils.CheckConvertParamToInt(context, context.Param("cardId"), id) {
		return
	}

	result, err := controller.studentService.GetByCardId(*id)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) updateStudentArrived(context *gin.Context) {
	cardId := new(int)
	courseId := new(int)

	if !utils.CheckConvertParamToInt(context, context.Param("cardId"), cardId) {
		return
	}

	if !utils.CheckConvertParamToInt(context, context.Param("courseId"), courseId) {
		return
	}

	result, err := controller.studentService.UpdateStudentArrived(
		*cardId, *courseId,
	)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) getByCourse(context *gin.Context) {
	courseId := new(int)

	if !utils.CheckConvertParamToInt(context, context.Param("courseId"), courseId) {
		return
	}
	result, err := controller.studentService.GetByCourse(*courseId)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) updateStudentLeft(context *gin.Context) {
	cardId := new(int)
	courseId := new(int)

	if !utils.CheckConvertParamToInt(context, context.Param("cardId"), cardId) {
		return
	}

	if !utils.CheckConvertParamToInt(context, context.Param("courseId"), courseId) {
		return
	}

	result, err := controller.studentService.UpdateStudentLeft(
		*cardId, *courseId,
	)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) reportStudentsExit(context *gin.Context) {
	var studentIds []int

	if !utils.CheckBodyContentBind(context, &studentIds) {
		return
	}

	result, err := controller.studentService.ReportStudentsExit(studentIds)

	utils.HandleStandardHTTPRequest(context, result, err)
}
