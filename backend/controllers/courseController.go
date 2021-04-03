package controllers

import (
	"dev.azure.com/u8635137/_git/Jedi/backend/models"
	"dev.azure.com/u8635137/_git/Jedi/backend/services"
	"dev.azure.com/u8635137/_git/Jedi/backend/utils"
	"github.com/gin-gonic/gin"
)

type CourseController struct {
	courseService 	services.CourseService
	studentService 	services.StudentService
}

func NewCourseController(
		routerGroup *gin.RouterGroup, 
		courseService services.CourseService,
		studentService services.StudentService,
	) {
	courseController := &CourseController{courseService, studentService}

	routerGroup.GET("/", courseController.getAll)
	routerGroup.GET("/courseId/:id/students", courseController.getStudents)
	routerGroup.GET("/current", courseController.getCurrent)
	routerGroup.GET("/courseId/:id", courseController.getById)
	routerGroup.GET("/courseId/:id/count", courseController.countStudentsInCourse)
	routerGroup.GET("/courseId/:id/count/arrived", courseController.countStudentsArrived)

	routerGroup.POST("/", courseController.addCourse)

	routerGroup.DELETE("/:id", courseController.deleteCourse)

	routerGroup.PUT("/", courseController.updateCourse)
}

func (controller *CourseController) getStudents(context *gin.Context) {
	id := new(int)

	if !utils.CheckConvertParamToInt(context, context.Param("id"), id) {
		return
	}

	result, err := controller.studentService.GetByCourse(*id)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *CourseController) getAll(context *gin.Context) {
	result, err := controller.courseService.GetAll()

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *CourseController) getCurrent(context *gin.Context) {
	result, err := controller.courseService.GetCurrentCourses()

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *CourseController) getById(context *gin.Context) {
	id := new(int)

	if !utils.CheckConvertParamToInt(context, context.Param("id"), id) {
		return
	}

	result, err := controller.courseService.GetById(*id)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *CourseController) countStudentsInCourse(context *gin.Context) {
	id := new(int)

	if !utils.CheckConvertParamToInt(context, context.Param("id"), id) {
		return
	}

	result, err := controller.courseService.CountStudentInCourse(*id)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *CourseController) countStudentsArrived(context *gin.Context) {
	id := new(int)

	if !utils.CheckConvertParamToInt(context, context.Param("id"), id) {
		return
	}

	result, err := controller.courseService.CountStudentArrivedInCourse(*id)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *CourseController) addCourse(context *gin.Context) {
	var course models.Course

	if !utils.CheckBodyContentBind(context, &course) {
		return
	}

	result, err := controller.courseService.AddCourse(course)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *CourseController) deleteCourse(context *gin.Context) {
	id := new(int)

	if !utils.CheckConvertParamToInt(context, context.Param("id"), id) {
		return
	}

	result, err := controller.courseService.DeleteCourse(*id)

	utils.HandleStandardHTTPRequest(context, result, err)
}

func (controller *CourseController) updateCourse(context *gin.Context) {
	var course models.Course

	if !utils.CheckBodyContentBind(context, &course) {
		return 
	}

	result, err := controller.courseService.UpdateCourse(course)

	utils.HandleStandardHTTPRequest(context, result, err)
}