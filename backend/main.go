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
	controllers.NewCourseController(
		route.Group("/courses"),
		*services.NewCourseService(
			repositories.NewCourseRepository(db),
			repositories.NewStudentRepository(db),
		),

	)

	controllers.NewMissingReasonController(
		route.Group("/missingReasons"),
		*services.NewMissingReasonService(
			repositories.NewMissingReasonRepository(db),
		),
	)

	controllers.NewReportTypeController(
		route.Group("/reportTypes"),
		*services.NewReportTypeService(
			repositories.NewReportTypeRepository(db),
		),
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