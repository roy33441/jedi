package services

import (
	"sort"
	"strings"

	"dev.azure.com/u8635137/_git/Jedi/backend/models"
)

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
	courses, err := service.courseRepository.GetAll()

	if err != nil {
		return nil, err
	}

	sortCoursesByName(courses)

	return courses, nil
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

	sortCoursesByName(courses)

	return courses, nil
}

func (service *CourseService) addStudents(course *models.Course) error {
	students, err := service.studentRepository.GetByCourseId(course.Id)

	if err != nil {
		return err
	}

	course.Students = students

	return nil
}

func (service *CourseService) GetById(courseId int) (*models.Course, error) {
	course, err := service.courseRepository.GetById(courseId)

	if err != nil {
		return nil, err
	}

	if err = service.addStudents(course); err != nil {
		return nil, err
	}

	return course, nil
}

func (service *CourseService) CountStudentInCourse(courseId int) (int, error) {
	return service.studentRepository.CountInCourse(courseId)
}

func (service *CourseService) CountStudentArrivedInCourse(courseId int) (int, error) {
	return service.studentRepository.CountArrivedInCourse(courseId)
}

func (service *CourseService) AddCourse(course models.Course) (*models.Course, error) {
	return service.courseRepository.Add(course)
}

func (service *CourseService) DeleteCourse(courseId int) (*models.Course, error) {
	return service.courseRepository.Delete(courseId)
}

func (service *CourseService) UpdateCourse(course models.Course) (*models.Course, error) {
	return service.courseRepository.Update(course)
}

func sortCoursesByName(courses *[]models.Course) {
	sort.SliceStable(*courses, func (i, j int) bool {
		return strings.ReplaceAll((*courses)[i].Name, "\"", "") <
				strings.ReplaceAll((*courses)[j].Name, "\"", "")
	})
}