package models

type ReportType struct {
	Id		int		`json:"id" db:"report_type_id"`
	Name	string	`json:"name" db:"report_type_name"`
}

const reportType_tablename string = "t_report_type"

type ReportTypeRepository interface {
	GetAll()			(*[]ReportType, error)
	Add(*ReportType)	(int64, error)
	GetById(int)		(*ReportType, error)
	DeleteById(int)		(*ReportType, error)
}