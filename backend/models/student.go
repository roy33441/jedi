package models

type Student struct {
	Id					int		`json:"id" db:"student_id"`
	CertificateNumber 	int 	`json:"certificate number" db:"certificate_number"`
	FullName			string 	`json:"full name" db:"full_name"`
	StudentNumber 		int 	`json:"student number" db:"student_number"`
	CourseId 			int 	`json:"course id" db:"course_id"`
	IsPresent			bool 	`json:"is present" db:"is_present"`
}

type StudentRepository interface {
	GetStudentInCourse(int)	(*[]Student, error)
}