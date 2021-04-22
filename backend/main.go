package main

import (
	"fmt"
	"log"
	"os"

	"dev.azure.com/u8635137/_git/Jedi/backend/config"
	"dev.azure.com/u8635137/_git/Jedi/backend/controllers"
	"dev.azure.com/u8635137/_git/Jedi/backend/repositories"
	"dev.azure.com/u8635137/_git/Jedi/backend/services"
	"github.com/gin-gonic/contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/jmoiron/sqlx"
	"github.com/joho/godotenv"
)

func init() {
	err := godotenv.Load()

	if err != nil {
		log.Fatal("Error loading .env file\t", err)
		panic(err)
	}

	gin.SetMode(os.Getenv("GIN_MODE"))
}

func initDB() *sqlx.DB {
	db, err := config.ConnectDB()

	if err != nil {
		log.Fatal("Error connecting to the db\t", err)
		panic(err)
	}

	return db
}

func initControllers(route *gin.Engine, db *sqlx.DB) {
	courseRepo := repositories.NewCourseRepository(db)
	studentRepo := repositories.NewStudentRepository(db)
	missingReasonRepo := repositories.NewMissingReasonRepository(db)
	reportTypeRepo := repositories.NewReportTypeRepository(db)
	studentReportRepo := repositories.NewStudentReportRepository(db)
	missingStudentRepo := repositories.NewMissingStudentRepository(db)

	studentService := services.NewStudentService(studentRepo)
	courseService := services.NewCourseService(courseRepo, studentRepo)
	missingReasonService := services.NewMissingReasonService(missingReasonRepo)
	reportTypeService := services.NewReportTypeService(reportTypeRepo)
	studentReportService := services.NewStudentReportService(studentReportRepo, reportTypeRepo)
	missingStudentService := services.NewMissingStudentService(missingStudentRepo, missingReasonRepo)

	controllers.NewCourseController(
		route.Group("/courses"),
		*courseService,
		*studentService,
	)

	controllers.NewMissingReasonController(
		route.Group("/missingReasons"),
		*missingReasonService,
	)

	controllers.NewReportTypeController(
		route.Group("/reportTypes"),
		*reportTypeService,
	)

	controllers.NewStudentController(
		route.Group("/students"),
		*studentService,
		*studentReportService,
		*missingStudentService,
	)
}

func main() {
	db := initDB()
	defer db.Close()

	route := gin.Default()

	route.Use(cors.Default())
	bindAddress := fmt.Sprintf("%s:%s", os.Getenv("HOST"), os.Getenv("PORT"))

	initControllers(route, db)

	route.Run(bindAddress)
}
