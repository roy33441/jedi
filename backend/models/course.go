package models

import (
	"github.com/jackc/pgtype"
)

type Course struct {
	Id			int			`json:"id,omitempty" db:"course_id"`
	Name 		string		`json:"name" db:"course_name"`
	Color_theme string		`json:"color theme" db:"color_theme"`
	Date_ending pgtype.Date	`json:"date ending" db:"date_ending"`
	Students 	*[]Student  `json:"students,omitempty"`
}

type CourseRepository interface {
	GetAll()							(*[]Course, error)
	GetCurrentCourses()					(*[]Course, error)
	GetById(string)						(*Course, error)
	Add(Course)							(*Course, error)
	Delete(string)						(*Course, error)
	Update(Course)						(*Course, error)
}