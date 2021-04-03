package repositories

import (
	"time"

	"dev.azure.com/u8635137/_git/Jedi/backend/models"
	"dev.azure.com/u8635137/_git/Jedi/backend/queries"
	"github.com/jmoiron/sqlx"
)

type PsqlStudentReportRepository struct {
	conn *sqlx.DB
}

func NewStudentReportRepository(conn *sqlx.DB) *PsqlStudentReportRepository {
	return &PsqlStudentReportRepository{conn}
}

func (psqlRepo *PsqlStudentReportRepository) DeleteByIdAndDate(
	studentId int,
	date time.Time,
	) (*models.StudentReport, error) {
	var studentReport models.StudentReport

	err := psqlRepo.conn.Get(
		&studentReport,
		queries.STUDENT_REPORT_DELETE_BY_ID_IN_DAY,
		studentId,
		date,
	)

	if err != nil {
		return nil, err
	}

	return &studentReport, nil
}

func (psqlRepo *PsqlStudentReportRepository) Add(
		studentReport models.StudentReport,
	) (*models.StudentReport, error) {
	var studentReportRet models.StudentReport

	rows, err := psqlRepo.conn.NamedQuery(
		queries.STUDENT_REPORT_ADD,
		studentReport,
	)

	if err != nil {
		return nil, err
	}

	for rows.Next() {
		if err = rows.StructScan(&studentReportRet); err != nil {
			return nil, err
		}
	}

	return &studentReportRet, nil
}
func (psqlRepo *PsqlStudentReportRepository) GetByStudentIdInDay(
		id int, day time.Time,
	) (*[]models.StudentReport, error) {
	studentReports := []models.StudentReport{}

	err := psqlRepo.conn.Select(
		&studentReports,
		queries.STUDENT_REPORT_GET_BY_STUDENT_ID_IN_DAY,
		id,
		day,
	)

	if err != nil {
		return nil, err
	}

	return &studentReports, nil
}