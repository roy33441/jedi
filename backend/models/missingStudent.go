package models

import (
	"time"

	"github.com/jackc/pgtype"
)

type MissingStudent struct {
	MissingId     int           `json:"missing_id" db:"missing_student_id"`
	StudentId     int           `json:"student_id" db:"student_id"`
	ReasonId      int           `json:"-" db:"reason_id"`
	MissingReason MissingReason `json:"reason,omitempty"`
	MissingOn     pgtype.Date   `json:"missing_on" db:"missing_on"`
}

type MissingStudentRepository interface {
	GetByDate(time.Time, int) (*[]MissingStudent, error)
	SaveStudentMissingReason(id int, date time.Time, reason *MissingReason) (*MissingStudent, error)
	RemoveStudentMissingReason(id int, date time.Time) (*MissingStudent, error)
}
