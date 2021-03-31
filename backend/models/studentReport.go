package models

import "github.com/jackc/pgtype"

type StudentReport struct {
	StudentReportId int 		`json:"student report id" db:"student_report_id"`
	ReportTypeId 	int			`json:"report type id" db:"report_type_id"`
	StudentId 		int 		`json:"student id" db:"student_id"`
	DateReported	pgtype.Date	`json:"date reported" db:"date_reported"`
}

const studentReport_tablename string = "t_student_report"

type StudentReportRepository interface {
	GetAll()			(*[]StudentReport, error)
	Add(*StudentReport)	(int64, error)
	GetById(int)		(*StudentReport, error)
	DeleteById(int)		(*StudentReport, error)
}
