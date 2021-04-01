package services

import (
	"strconv"

	"dev.azure.com/u8635137/_git/Jedi/backend/core"
	"dev.azure.com/u8635137/_git/Jedi/backend/models"
)

type StudentService struct {
	studentRepository models.StudentRepository
}

func NewStudentService(repository models.StudentRepository) *StudentService {
	return &StudentService{repository}
}

func (service *StudentService) GetAll() (*[]models.Student, error) {
	return service.studentRepository.GetAll()
}

func (service *StudentService) AddStudent(student models.Student) (*models.Student, error) {
	return service.studentRepository.Add(student)
}

func (service *StudentService) DeleteStudent(studentId string) (*models.Student, error) {
	return service.studentRepository.Delete(studentId)
}

func (service *StudentService) UpdateStudent(student models.Student) (*models.Student, error) {
	return service.studentRepository.Update(student)
}

func (service *StudentService) GetByCardId(cardId string) (*models.Student, error) {
	return service.studentRepository.GetByCardId(cardId)
}

func (service *StudentService) UpdateStudentArrived(
		cardId string, courseId string,
	) (*models.Student, error) {
	return service.updateStudentPresent(cardId, courseId, true)
}

func (service *StudentService) UpdateStudentLeft(
		cardId string, courseId string,
	) (*models.Student, error) {
	return service.updateStudentPresent(cardId, courseId, false)
}

func (service *StudentService) updateStudentPresent(
		cardId string, courseId string, present bool,
	) (*models.Student, error) {
	student, err := service.GetByCardId(cardId)
	
	if err != nil {
		return nil, err
	}

	if courseId != strconv.Itoa(student.CourseId) {
		return nil, core.NewUnauthorizedInCourseError()
	}

	if present && student.IsPresent {
		return nil, core.NewStudentAlreadyArrivedError()
	}

	student.IsPresent = present
	
	return service.UpdateStudent(*student)
} 

func (service *StudentService) GetByCourse(courseId string) (*[]models.Student, error){
	return service.studentRepository.GetByCourseId(courseId)
}

func (service *StudentService) ReportStudentsExit(studentsIds []int) (*[]models.Student, error) {
	students := make([]models.Student, len(studentsIds))

	for i, id := range studentsIds {
		student, err := service.studentRepository.UpdatePresent(strconv.Itoa(id), false)

		if err != nil {
			return nil, err
		}

		students[i] = *student
	}

	return &students, nil
}