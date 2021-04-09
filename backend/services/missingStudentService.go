package services

import (
	"time"

	"dev.azure.com/u8635137/_git/Jedi/backend/models"
)

type MissingStudentService struct {
	missingStudentRepository models.MissingStudentRepository
	missingReasonRepository  models.MissingReasonRepository
}

func NewMissingStudentService(
	missingStudentRepository models.MissingStudentRepository,
	missingReasonRepository models.MissingReasonRepository,
) *MissingStudentService {
	return &MissingStudentService{missingStudentRepository, missingReasonRepository}
}

func (service *MissingStudentService) ReportStudentMissingReason(
	id int,
	date time.Time,
	reason *models.MissingReason,
) (*models.MissingStudent, error) {
	missingStudent, err := service.missingStudentRepository.SaveStudentMissingReason(id, date, reason)

	if err != nil {
		return nil, err
	}

	missingReason, err := service.missingReasonRepository.GetById(missingStudent.ReasonId)

	if err != nil {
		return nil, err
	}

	missingStudent.MissingReason = *missingReason

	return missingStudent, nil
}
func (service *MissingStudentService) GetMissingAtDate(date time.Time) (*[]models.MissingStudent, error) {
	missingStudents, err := service.missingStudentRepository.GetByDate(date)

	if err != nil {
		return nil, err
	}

	for index := range *missingStudents {
		missingReason, err := service.missingReasonRepository.GetById((*missingStudents)[index].ReasonId)

		if err != nil {
			return nil, err
		}

		(*missingStudents)[index].MissingReason = *missingReason
	}

	return missingStudents, nil
}
