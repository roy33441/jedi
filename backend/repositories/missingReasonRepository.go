package repositories

import (
	"dev.azure.com/u8635137/_git/Jedi/backend/models"
	"dev.azure.com/u8635137/_git/Jedi/backend/queries"
	"github.com/jmoiron/sqlx"
)

type PsqlMissingReasonRepository struct {
	conn *sqlx.DB
}

func NewMissingReasonRepository(conn *sqlx.DB) *PsqlMissingReasonRepository {
	return &PsqlMissingReasonRepository{conn}
} 

func (psqlRepo *PsqlMissingReasonRepository) GetById(id int) (*models.MissingReason, error) {
	var missingReason models.MissingReason

	err := psqlRepo.conn.Get(
		&missingReason,
		queries.MISSING_REASON_GET_BY_ID,
		id,
	)

	if err != nil {
		return nil, err
	}

	return &missingReason, nil
}

func (psqlRepo *PsqlMissingReasonRepository) GetAll() (*[]models.MissingReason, error) {
	missingReasons := []models.MissingReason{}

	err := psqlRepo.conn.Select(
		&missingReasons,
		queries.MISSING_REASON_GET_ALL,
	)

	if err != nil {
		return nil, err
	}

	return &missingReasons, nil
}

func (psqlRepo *PsqlMissingReasonRepository) Add(
		missingReason models.MissingReason,
	) (*models.MissingReason, error) {
	var missingReasonRet models.MissingReason

	rows, err := psqlRepo.conn.NamedQuery(
		queries.MISSING_REASON_ADD,
		missingReason,
	)

	if err != nil {
		return nil, err
	}

	for rows.Next() {
		if err = rows.StructScan(&missingReasonRet); err != nil {
			return nil, err
		}
	}

	return &missingReasonRet, nil
}

func (psqlRepo *PsqlMissingReasonRepository) Delete(
		missingReasonId int,
	) (*models.MissingReason, error) {
	var missingReasonRet models.MissingReason

	err := psqlRepo.conn.Get(
		&missingReasonRet,
		queries.MISSING_REASON_DELETE,
		missingReasonId,
	)

	if err != nil {
		return nil, err
	}

	return &missingReasonRet, nil
}

func (psqlRepo *PsqlMissingReasonRepository) Update(
		missingReason models.MissingReason,
	) (*models.MissingReason, error) {
	var missingReasonRet models.MissingReason

	rows, err := psqlRepo.conn.NamedQuery(
		queries.MISSING_REASON_UPDATE,
		missingReason,
	)

	if err != nil {
		return nil, err
	}

	for rows.Next() {
		if err = rows.StructScan(&missingReasonRet); err != nil {
			return nil, err
		}
	}

	return &missingReasonRet, nil
}