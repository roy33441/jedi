package repositories

import (
	"dev.azure.com/u8635137/_git/Jedi/backend/models"
	"dev.azure.com/u8635137/_git/Jedi/backend/queries"
	"github.com/jmoiron/sqlx"
)

type PsqlReportTypeRepository struct {
	conn *sqlx.DB
}

func NewReportTypeRepository(conn *sqlx.DB) *PsqlReportTypeRepository {
	return &PsqlReportTypeRepository{conn}
} 

func (psqlRepo *PsqlReportTypeRepository) GetById(id int) (*models.ReportType, error) {
	var reportType models.ReportType

	err := psqlRepo.conn.Get(
		&reportType,
		queries.REPORT_TYPE_GET_BY_ID,
		id,
	)

	if err != nil {
		return nil, err
	}

	return &reportType, nil
}

func (psqlRepo *PsqlReportTypeRepository) GetAll() (*[]models.ReportType, error) {
	ReportTypes := []models.ReportType{}

	err := psqlRepo.conn.Select(
		&ReportTypes,
		queries.REPORT_TYPE_GET_ALL,
	)

	if err != nil {
		return nil, err
	}

	return &ReportTypes, nil
}

func (psqlRepo *PsqlReportTypeRepository) Add(
		reportType models.ReportType,
	) (*models.ReportType, error) {
	var reportTypeRet models.ReportType

	rows, err := psqlRepo.conn.NamedQuery(
		queries.REPORT_TYPE_ADD,
		reportType,
	)

	if err != nil {
		return nil, err
	}

	for rows.Next() {
		if err = rows.StructScan(&reportTypeRet); err != nil {
			return nil, err
		}
	}

	return &reportTypeRet, nil
}

func (psqlRepo *PsqlReportTypeRepository) Delete(
		ReportTypeId int,
	) (*models.ReportType, error) {
	var ReportTypeRet models.ReportType

	err := psqlRepo.conn.Get(
		&ReportTypeRet,
		queries.REPORT_TYPE_DELETE,
		ReportTypeId,
	)

	if err != nil {
		return nil, err
	}

	return &ReportTypeRet, nil
}

func (psqlRepo *PsqlReportTypeRepository) Update(
		ReportType models.ReportType,
	) (*models.ReportType, error) {
	var ReportTypeRet models.ReportType

	rows, err := psqlRepo.conn.NamedQuery(
		queries.REPORT_TYPE_UPDATE,
		ReportType,
	)

	if err != nil {
		return nil, err
	}

	for rows.Next() {
		if err = rows.StructScan(&ReportTypeRet); err != nil {
			return nil, err
		}
	}

	return &ReportTypeRet, nil
}