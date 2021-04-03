package services

import (
	"time"

	"dev.azure.com/u8635137/_git/Jedi/backend/models"
)

type StudentReportService struct {
	studentReportRepository models.StudentReportRepository
	reportTypeRepository    models.ReportTypeRepository
}

func NewStudentReportService(
	studentReportRepository models.StudentReportRepository,
	reportTypeRepository models.ReportTypeRepository,
) *StudentReportService {
	return &StudentReportService{studentReportRepository, reportTypeRepository}
}

func (service *StudentReportService) AddStudentReportDay(
	studentId int,
	day time.Time,
	reportTypeIds []int,
) (*[]models.StudentReport, error) {
	studentReports := []models.StudentReport{}

	_, err := service.studentReportRepository.DeleteByIdAndDate(studentId, day)

	if err != nil {
		return nil, err
	}

	for _, reportTypeId := range reportTypeIds {

		studentsReport, err := service.studentReportRepository.Add(
			models.StudentReport{
				StudentId:    studentId,
				DateReported: day,
				ReportTypeId: reportTypeId,
			},
		)

		if err != nil {
			return nil, err
		}

		studentReports = append(studentReports, *studentsReport)
	}

	for index := range studentReports {
		if err := service.addReportType(&studentReports[index]); err != nil {
			return nil, err
		}
	}

	return &studentReports, nil
}

func (service *StudentReportService) GetStudentReportDay(
	studentId int, day time.Time,
) (*[]models.StudentReport, error) {
	studentReports, err := service.studentReportRepository.GetByStudentIdInDay(studentId, day)

	if err != nil {
		return nil, err
	}

	for index := range *studentReports {
		if err := service.addReportType(&(*studentReports)[index]); err != nil {
			return nil, err
		}
	}

	return studentReports, nil
}

func (service *StudentReportService) addReportType(studentReport *models.StudentReport) error {
	reportType, err := service.reportTypeRepository.GetById(studentReport.ReportTypeId)

	if err != nil {
		return nil
	}

	studentReport.ReportType = reportType

	return nil
}
