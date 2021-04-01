package services

import "dev.azure.com/u8635137/_git/Jedi/backend/models"

type CourseService struct {
	courseRepository models.CourseRepository
	studentRepository models.StudentRepository
}

func NewCourseService(
	courseRepository models.CourseRepository,
	studentRepository models.StudentRepository) *CourseService {
		
	return &CourseService{courseRepository, studentRepository}
}

func (service *CourseService) GetAll() (*[]models.Course, error){
	return service.courseRepository.GetAll()
}

func (service *CourseService) GetCurrentCourses() (*[]models.Course, error) {
	courses, err := service.courseRepository.GetCurrentCourses()

	if err != nil {
		return nil ,err
	}

	for index := range *courses {
		if err := service.addStudents(&((*courses)[index])); err != nil {
			return nil ,err
		}		
	}

	return courses, nil
}

func (service *CourseService) addStudents(course *models.Course) error {
	students, err := service.studentRepository.GetStudentInCourse(course.Id)

	if err != nil {
		return err
	}

	course.Students = students

	return nil
}

func (service *CourseService) GetById(courseId string) (*models.Course, error) {
	course, err := service.courseRepository.GetById(courseId)

	if err != nil {
		return nil, err
	}

	if err = service.addStudents(course); err != nil {
		return nil, err
	}

	return course, nil
}

func (service *CourseService) CountStudentInCourse(courseId string) (int, error) {
	return service.courseRepository.CountStudentInCourse(courseId)
}

func (service *CourseService) CountStudentArrivedInCourse(courseId string) (int, error) {
	return service.courseRepository.CountStudentArrivedInCourse(courseId)
}

func (service *CourseService) AddCourse(course models.Course) (*models.Course, error) {
	return service.courseRepository.Add(course)
}

func (service *CourseService) DeleteCourse(courseId string) (*models.Course, error) {
	return service.courseRepository.Delete(courseId)
}

func (service *CourseService) UpdateCourse(course models.Course) (*models.Course, error) {
	return service.courseRepository.Update(course)
}