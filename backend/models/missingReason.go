package models

type MissingReason struct {
	Id		int		`json:"id" db:"reason_id"`
	Text	string	`json:"text" db:"reason_text"`
}

const missingReason_tablename string = "t_missing_reason"

type MissingReasonRepository interface {
	GetAll()			(*[]MissingReason, error)
	Add(*MissingReason)	(int64, error)
	GetById(int)		(*MissingReason, error)
	DeleteById(int)		(*MissingReason, error)
}