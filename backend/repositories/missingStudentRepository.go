package repositories

import (
	"time"

	"dev.azure.com/u8635137/_git/Jedi/backend/models"
	"dev.azure.com/u8635137/_git/Jedi/backend/queries"
	"github.com/jmoiron/sqlx"
)

type PsqlMissingStudentRepository struct {
	conn *sqlx.DB
}

func NewMissingStudentRepository(conn *sqlx.DB) *PsqlMissingStudentRepository {
	return &PsqlMissingStudentRepository{conn}
}

func (psqlRepo *PsqlMissingStudentRepository) GetByDate(
		day time.Time,
	) (*[]models.MissingStudent, error) {
	missingStudents := []models.MissingStudent{}

	err := psqlRepo.conn.Select(
		&missingStudents,
		queries.MISSING_STUDENT_GET_BY_DATE,
		day,
	)

	if err != nil {
		return nil, err
	}

	return &missingStudents, nil
}

