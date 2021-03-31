package repositories

import (
	"dev.azure.com/u8635137/_git/Jedi/backend/models"
	"dev.azure.com/u8635137/_git/Jedi/backend/queries"
	"github.com/jmoiron/sqlx"
)

type PsqlStudentRepository struct {
	conn *sqlx.DB
}

func NewStudentRepository(conn *sqlx.DB) *PsqlStudentRepository {
	return &PsqlStudentRepository{conn}
}

func (psqlRepo *PsqlStudentRepository) GetStudentInCourse(courseId int) (*[]models.Student, error) {
	students := []models.Student{}

	err := psqlRepo.conn.Select(
		&students,
		queries.STUDENT_GET_FROM_COURSE,
		courseId,
	)

	if err != nil {
		return nil, err
	}

	return &students, err
}