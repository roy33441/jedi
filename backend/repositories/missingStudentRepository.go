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

func (pgsqlRepo *PsqlMissingStudentRepository) SaveStudentMissingReason(id int, date time.Time, reason *models.MissingReason) (*models.MissingStudent, error) {
	missingStudent := []models.MissingStudent{}
	err := pgsqlRepo.conn.Select(&missingStudent, queries.SAVE_MISSING_STUDENT, id, reason.Id, date)

	if err != nil {
		return nil, err
	}

	return &missingStudent[0], nil
}

func (pgsqlRepo *PsqlMissingStudentRepository) RemoveStudentMissingReason(id int, date time.Time) (*models.MissingStudent, error) {
	missingStudent := []models.MissingStudent{}
	err := pgsqlRepo.conn.Select(&missingStudent, queries.REMOVE_MISSING_STUDENT, id)

	if err != nil {
		return nil, err
	}

	return &missingStudent[0], nil
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
