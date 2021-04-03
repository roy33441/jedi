package models

import (
	"time"

	"github.com/jackc/pgtype"
)

type MissingStudent struct {
	MissingId		int				`json:"missing id" db:"missing_student_id"`
	StudentId		int				`json:"student id" db:"student_id"`
	ReasonId 		int				`json:"reason id" db:"reason_id"`
	MissingReason	MissingReason	`json:"reason,omitempty"`
	MissingOn 		pgtype.Date		`json:"missing on" db:"missing_on"`
}

type MissingStudentRepository interface {
	GetByDate(time.Time)	(*[]MissingStudent, error) 
}