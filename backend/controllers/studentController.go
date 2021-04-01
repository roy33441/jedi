package controllers

import (
	"fmt"
	"net/http"

	"dev.azure.com/u8635137/_git/Jedi/backend/models"
	"dev.azure.com/u8635137/_git/Jedi/backend/services"
	"github.com/gin-gonic/gin"
)

type StudentController struct {
	studentService services.StudentService
}

func NewStudentController(
	router *gin.RouterGroup, 
	studentService services.StudentService) {
		controller := StudentController{studentService}
		
		router.GET("/card/:cardId", controller.getByCardId)
		router.GET("/", controller.getAll)
		router.GET("/course/:courseId", controller.getByCourse)
		
		router.DELETE("/:id", controller.deleteStudent)
	
		router.POST("/", controller.addStudent)
		
		router.PUT("/card/:cardId/arrived/course/:courseId", controller.updateStudentArrived)
		router.PUT("/", controller.updateStudent)
		router.PUT("/card/:cardId/left/course/:courseId", controller.updateStudentLeft)
		router.PUT("/exit", controller.reportStudentsExit)
}

func (controller *StudentController) getAll(context *gin.Context) {
	result, err := controller.studentService.GetAll()

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) addStudent(context *gin.Context) {
	var student models.Student

	if err := context.ShouldBind(&student); err != nil {
		fmt.Println("Error: " + err.Error())

		context.AbortWithStatusJSON(
			http.StatusBadRequest,
			gin.H{
				"error": "invalid variable request",
			},
		)

		return 

	}

	result, err := controller.studentService.AddStudent(student)

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) deleteStudent(context *gin.Context) {
	result, err := controller.studentService.DeleteStudent(context.Param("id"))

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) updateStudent(context *gin.Context) {
	var student models.Student

	if err := context.ShouldBind(&student); err != nil {
		fmt.Println("Error: " + err.Error())

		context.AbortWithStatusJSON(
			http.StatusBadRequest,
			gin.H{
				"error": "invalid variable request",
			},
		)

		return 
	}

	result, err := controller.studentService.UpdateStudent(student)

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) getByCardId(context *gin.Context) {
	result, err := controller.studentService.GetByCardId(context.Param("cardId"))

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) updateStudentArrived(context *gin.Context) {
	result, err := controller.studentService.UpdateStudentArrived(
		context.Param("cardId"), context.Param("courseId"),
	)

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) getByCourse(context *gin.Context) {
	result, err := controller.studentService.GetByCourse(context.Param("courseId"))

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) updateStudentLeft(context *gin.Context) {
	result, err := controller.studentService.UpdateStudentLeft(
		context.Param("cardId"), context.Param("courseId"),
	)

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *StudentController) reportStudentsExit(context *gin.Context) {
	var studentIds []int

	if err := context.ShouldBind(&studentIds); err != nil {
		fmt.Println("Error: " + err.Error())

		context.AbortWithStatusJSON(
			http.StatusBadRequest,
			gin.H{
				"error": "invalid variable request",
			},
		)

		return 
	}
	
	result, err := controller.studentService.ReportStudentsExit(studentIds)

	HandleStandardHTTPRequest(context, result, err)
}