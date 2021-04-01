package repositories

import (
	"time"

	"dev.azure.com/u8635137/_git/Jedi/backend/models"
	"dev.azure.com/u8635137/_git/Jedi/backend/queries"
	"github.com/jmoiron/sqlx"
)

type PsqlCourseRepository struct {
	conn *sqlx.DB
}

func NewCourseRepository(conn *sqlx.DB) *PsqlCourseRepository {
	return &PsqlCourseRepository{conn}
}

func (psqlRepo *PsqlCourseRepository) GetAll() (*[]models.Course, error) {
	courses := []models.Course{}

	err := psqlRepo.conn.Select(
		&courses,
		queries.COURSE_GET_ALL,
	)

	if err != nil {
		return nil, err
	}

	return &courses, nil
}

func (psqlRepo *PsqlCourseRepository) GetCurrentCourses() (*[]models.Course, error) {
	courses := []models.Course{}

	err := psqlRepo.conn.Select(
		&courses,
		queries.COURSE_GET_CURRENT,
		time.Now(),
	)

	if err != nil {
		return nil, err
	}

	return &courses, nil
}

func (psqlRepo *PsqlCourseRepository) GetById(courseId string) (*models.Course, error) {
	course := models.Course{}

	err := psqlRepo.conn.Get(
		&course,
		queries.COURSE_GET_BY_ID,
		courseId,
	)

	if err != nil {
		return nil, err
	}

	return &course, nil
}



func (psqlRepo *PsqlCourseRepository) Add(course models.Course) (*models.Course, error) {
	var courseRet models.Course

	rows, err := psqlRepo.conn.NamedQuery(
		queries.COURSE_ADD,
		course,
	)

	if err != nil {
		return nil, err
	}

	for rows.Next() {
		if err = rows.StructScan(&courseRet); err != nil {
			return nil, err
		}
	}

	return &courseRet, nil
}

func (psqlRepo *PsqlCourseRepository) Delete(courseId string) (*models.Course, error) {
	var courseRet models.Course

	err := psqlRepo.conn.Get(
		&courseRet,
		queries.COURSE_DELETE,
		courseId,
	)

	if err != nil {
		return nil, err
	}

	return &courseRet, nil
} 

func (psqlRepo *PsqlCourseRepository) Update(course models.Course) (*models.Course, error) {
	var courseRet models.Course

	rows, err := psqlRepo.conn.NamedQuery(
		queries.COURSE_UPDATE,
		course,
	)

	if err != nil {
		return nil, err
	}

	for rows.Next() {
		if err = rows.StructScan(&courseRet); err != nil {
			return nil, err
		}
	}

	return &courseRet, nil
}