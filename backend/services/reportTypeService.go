package services

import "dev.azure.com/u8635137/_git/Jedi/backend/models"

type ReportTypeService struct {
	reportTypeRepository models.ReportTypeRepository
}

func NewReportTypeService(repository models.ReportTypeRepository) *ReportTypeService {
	return &ReportTypeService{repository}
}

func (service *ReportTypeService) GetAll() (*[]models.ReportType, error) {
	return service.reportTypeRepository.GetAll()
}

func (service *ReportTypeService) AddReportType(reportType models.ReportType) (*models.ReportType, error) {
	return service.reportTypeRepository.Add(reportType)
}

func (service *ReportTypeService) DeleteReportType(reportTypeId int) (*models.ReportType, error) {
	return service.reportTypeRepository.Delete(reportTypeId)
}

func (service *ReportTypeService) UpdateReportType(reportType models.ReportType) (*models.ReportType, error) {
	return service.reportTypeRepository.Update(reportType)
}