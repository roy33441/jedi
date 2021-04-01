package core

type UnauthorizedInCourseError struct {
	statusCode 	int
	massage		string
}

func NewUnauthorizedInCourseError() *UnauthorizedInCourseError {
	return &UnauthorizedInCourseError{
		statusCode: 401,
		massage: "Student not in course",
	}
}

func (err *UnauthorizedInCourseError) Error() string {
	return err.massage
}

func (err *UnauthorizedInCourseError) Status() int {
	return err.statusCode
}

