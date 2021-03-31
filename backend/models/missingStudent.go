package models

import "github.com/jackc/pgtype"

type MissingStudent struct {
	MissingId	int			`json:"missing id" db:"missing_student_id"`
	StudentId	int			`json:"student id" db:"student_id"`
	ReasonId 	int			`json:"reason id" db:"reason_id"`
	MissingOn 	pgtype.Date	`json:"missing on" db:"missing_on"`
}

const missingStudent_tablename string = "t_missing_student"

type MissingStudentRepository interface {
	GetAll()				(*[]MissingStudent, error)
	Add(*MissingStudent)	(int64, error)
	GetById(int)			(*MissingStudent, error)
	DeleteById(int)			(*MissingStudent, error)
}