package models

type ReportType struct {
	Id		int		`json:"id" db:"report_type_id"`
	Name	string	`json:"name" db:"report_type_name"`
}

type ReportTypeRepository interface {
	GetAll()			(*[]ReportType, error)
	Add(ReportType)		(*ReportType, error)
	Update(ReportType)	(*ReportType, error)
	Delete(int)			(*ReportType, error)
	GetById(int)		(*ReportType, error)
}