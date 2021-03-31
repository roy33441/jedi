package controllers

import (
	"net/http"

	"dev.azure.com/u8635137/_git/Jedi/backend/models"
	"dev.azure.com/u8635137/_git/Jedi/backend/services"
	"github.com/gin-gonic/gin"
)

type CourseController struct {
	courseService services.CourseService
}

func NewCourseController(routerGroup *gin.RouterGroup, courseService services.CourseService) {
	courseController := &CourseController{courseService}

	routerGroup.GET("/", courseController.getAll)
	routerGroup.GET("/current", courseController.getCurrent)
	routerGroup.GET("/courseId/:id", courseController.getById)
	routerGroup.GET("/courseId/:id/count", courseController.countStudentsInCourse)
	routerGroup.GET("/courseId/:id/count/arrived", courseController.countStudentsArrived)

	routerGroup.POST("/", courseController.addCourse)

	routerGroup.DELETE("/:id", courseController.deleteCourse)

	routerGroup.PUT("/", courseController.updateCourse)
}

func (controller *CourseController) getAll(context *gin.Context) {
	result, err := controller.courseService.GetAll()

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *CourseController) getCurrent(context *gin.Context) {
	result, err := controller.courseService.GetCurrentCourses()

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *CourseController) getById(context *gin.Context) {
	result, err := controller.courseService.GetById(context.Param("id"))

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *CourseController) countStudentsInCourse(context *gin.Context) {
	result, err := controller.courseService.CountStudentInCourse(context.Param("id"))

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *CourseController) countStudentsArrived(context *gin.Context) {
	result, err := controller.courseService.CountStudentArrivedInCourse(context.Param("id"))

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *CourseController) addCourse(context *gin.Context) {
	var course models.Course

	if err := context.ShouldBind(&course); err != nil {
		context.AbortWithError(
			http.StatusBadRequest,
			err,
		)

		return 
	}

	result, err := controller.courseService.AddCourse(course)

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *CourseController) deleteCourse(context *gin.Context) {
	result, err := controller.courseService.DeleteCourse(context.Param("id"))

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *CourseController) updateCourse(context *gin.Context) {
	var course models.Course

	if err := context.ShouldBind(&course); err != nil {
		context.AbortWithError(
			http.StatusBadRequest,
			err,
		)

		return 
	}

	result, err := controller.courseService.UpdateCourse(course)

	HandleStandardHTTPRequest(context, result, err)
}

func (controller *CourseController) formationEnd(context *gin.Context) {
	//TODO: need to update missing students with late
}