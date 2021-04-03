package services

import "dev.azure.com/u8635137/_git/Jedi/backend/models"

type MissingReasonService struct {
	missingReasonRepository models.MissingReasonRepository
}

func NewMissingReasonService(repository models.MissingReasonRepository) *MissingReasonService {
	return &MissingReasonService{repository}
}

func (service *MissingReasonService) GetAll() (*[]models.MissingReason, error) {
	return service.missingReasonRepository.GetAll()
}

func (service *MissingReasonService) AddMissingReason(
		missingReason models.MissingReason,
	) (*models.MissingReason, error) {
	return service.missingReasonRepository.Add(missingReason)
}

func (service *MissingReasonService) DeleteMissingReason(
		missingReasonId int,
	) (*models.MissingReason, error) {
	return service.missingReasonRepository.Delete(missingReasonId)
}

func (service *MissingReasonService) UpdateMissingReason(
		missingReason models.MissingReason,
	) (*models.MissingReason, error) {
	return service.missingReasonRepository.Update(missingReason)
}