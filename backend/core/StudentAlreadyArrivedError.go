package core

type StudentAlreadyArrivedError struct {
	statusCode 	int
	massage		string
}

func NewStudentAlreadyArrivedError () *StudentAlreadyArrivedError {
	return &StudentAlreadyArrivedError{
		statusCode: 202,
		massage: "Student signed in already",
	}
}

func (err *StudentAlreadyArrivedError) Error() string {
	return err.massage
}

func (err *StudentAlreadyArrivedError) Status() int {
	return err.statusCode
}