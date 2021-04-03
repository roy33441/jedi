package models

type MissingReason struct {
	Id   int    `json:"id" db:"reason_id"`
	Text string `json:"text" db:"reason_text"`
}

type MissingReasonRepository interface {
	GetAll() (*[]MissingReason, error)
	Add(MissingReason) (*MissingReason, error)
	Delete(int) (*MissingReason, error)
	Update(MissingReason) (*MissingReason, error)
	GetById(int) (*MissingReason, error)
}
