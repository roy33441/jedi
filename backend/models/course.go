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
	CountStudentInCourse(string)		(int, error)
	CountStudentArrivedInCourse(string)	(int, error)
	AddCourse(Course)					(*Course, error)
	DeleteCourse(string)				(*Course, error)
	UpdateCourse(Course)				(*Course, error)
}