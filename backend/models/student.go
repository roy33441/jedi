package models

import "time"

type Student struct {
	Id                int    `json:"id" db:"student_id"`
	CertificateNumber int    `json:"certificate_number" db:"certificate_number"`
	FullName          string `json:"full_name" db:"full_name"`
	StudentNumber     int    `json:"student_number" db:"student_number"`
	CourseId          int    `json:"course_id" db:"course_id"`
	IsPresent         bool   `json:"is_present" db:"is_present"`
}

type StudentRepository interface {
	GetByCourseId(int)					(*[]Student, error)
	CountInCourse(int)					(int, error)
	CountArrivedInCourse(int)			(int, error)
	GetAll()							(*[]Student, error)
	GetByCardId(int)					(*Student, error)
	UpdatePresent(int, bool)			(*Student, error)
	Add(Student)						(*Student, error)
	Delete(int)							(*Student, error)
	Update(Student)						(*Student, error)
	ResetPresent(time.Time)				(int, error)
}
