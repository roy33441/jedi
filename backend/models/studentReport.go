package models

import "time"

type StudentReport struct {
	StudentReportId int         `json:"student_report_id" db:"student_report_id"`
	ReportTypeId    int         `json:"-" db:"report_type_id"`
	ReportType      *ReportType `json:"report_type,omitempy"`
	StudentId       int         `json:"student_id" db:"student_id"`
	DateReported    time.Time   `json:"date_reported" db:"date_reported"`
}

type StudentReportRepository interface {
	GetByStudentIdInDay(int, time.Time) (*[]StudentReport, error)
	Add(StudentReport) (*StudentReport, error)
	DeleteByIdAndDate(int, time.Time) (*StudentReport, error)
}
