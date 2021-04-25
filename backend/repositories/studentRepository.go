package repositories

import (
	"time"

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

func (psqlRepo *PsqlStudentRepository) GetByCourseId(courseId int) (*[]models.Student, error) {
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

func (psqlRepo *PsqlStudentRepository) GetAll() (*[]models.Student, error) {
	students := []models.Student{}

	err := psqlRepo.conn.Select(
		&students,
		queries.STUDENT_GET_ALL,
	)

	if err != nil {
		return nil, err
	}

	return &students, nil
}

func (psqlRepo *PsqlStudentRepository) Add(
		student models.Student,
	) (*models.Student, error) {
	var studentRet models.Student

	rows, err := psqlRepo.conn.NamedQuery(
		queries.STUDENT_ADD,
		student,
	)

	if err != nil {
		return nil, err
	}

	for rows.Next() {
		if err = rows.StructScan(&studentRet); err != nil {
			return nil, err
		}
	}

	return &studentRet, nil
}

func (psqlRepo *PsqlStudentRepository) Delete(
		studentId int,
	) (*models.Student, error) {
	var studentRet models.Student

	err := psqlRepo.conn.Get(
		&studentRet,
		queries.STUDENT_DELETE,
		studentId,
	)

	if err != nil {
		return nil, err
	}

	return &studentRet, nil
}

func (psqlRepo *PsqlStudentRepository) Update(
		student models.Student,
	) (*models.Student, error) {
	var studentRet models.Student

	rows, err := psqlRepo.conn.NamedQuery(
		queries.STUDENT_UPDATE,
		student,
	)

	if err != nil {
		return nil, err
	}

	for rows.Next() {
		if err = rows.StructScan(&studentRet); err != nil {
			return nil, err
		}
	}

	return &studentRet, nil
}

func (psqlRepo *PsqlStudentRepository) CountInCourse(courseId int) (int, error) {
	var count int

	err := psqlRepo.conn.Get(
		&count,
		queries.STUDENT_COUNT_IN_COURSE,
		courseId,
	)

	if err != nil {
		return 0, err
	}

	return count, nil
}

func (psqlRepo *PsqlStudentRepository) CountArrivedInCourse(courseId int) (int, error) {
	var count int

	err := psqlRepo.conn.Get(
		&count,
		queries.STUDENT_GET_FROM_COURSE_ARRIVED,
		courseId,
	)

	if err != nil {
		return 0, err
	}

	return count, nil
}

func (psqlRepo *PsqlStudentRepository) GetByCardId(cardId int) (*models.Student, error) {
	var student models.Student

	err := psqlRepo.conn.Get(
		&student,
		queries.STUDENT_GET_BY_CARD,
		cardId,
	)

	if err != nil {
		return nil, err
	}

	return &student, nil
}

func (psqlRepo *PsqlStudentRepository) UpdatePresent(id int, present bool) (*models.Student, error) {
	var student models.Student

	err := psqlRepo.conn.Get(
		&student,
		queries.STUDENT_UPDATE_PRESENT,
		present,
		id,
	)

	if err != nil {
		return nil, err
	}

	return &student, nil
}

func (psqlRepo *PsqlStudentRepository) ResetPresent(today time.Time) (int, error) {
	result, err := psqlRepo.conn.Exec(
		queries.STUDENT_RESET_PRESENT,
		today,
	)

	if err != nil {
		return 0, err
	}

	effectedCount, err := result.RowsAffected()

	if err != nil {
		return 0, err
	}

	return int(effectedCount), nil
}