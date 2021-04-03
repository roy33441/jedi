package models

import "time"

type StudentReport struct {
	StudentReportId int 		`json:"student report id" db:"student_report_id"`
	ReportTypeId 	int			`json:"report type id" db:"report_type_id"`
	ReportType		*ReportType	`json:"report type,omitempy"`
	StudentId 		int 		`json:"student id" db:"student_id"`
	DateReported	time.Time	`json:"date reported" db:"date_reported"`
}

type StudentReportRepository interface {
	GetByStudentIdInDay(int, time.Time)	(*[]StudentReport, error)
	Add(StudentReport)					(*StudentReport, error)
	DeleteByIdAndDate(int, time.Time)	(*StudentReport, error)
}
