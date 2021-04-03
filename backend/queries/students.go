package queries

import (
	"fmt"

	"dev.azure.com/u8635137/_git/Jedi/backend/config"
)

const studentTable = config.SchemaName + ".t_student"

var (
	STUDENT_GET_FROM_COURSE = fmt.Sprintf(
		"SELECT * FROM %s WHERE course_id=$1", 
		studentTable,
	)
	STUDENT_COUNT_IN_COURSE = fmt.Sprintf(
		"SELECT count(*) FROM %s WHERE course_id=$1",
		studentTable,
	)
	STUDENT_GET_FROM_COURSE_ARRIVED = fmt.Sprintf(
		"SELECT count(*) FROM %s WHERE course_id=$1 AND is_present=true",
		studentTable,
	)
	STUDENT_GET_ALL = fmt.Sprintf(
		"SELECT * FROM %s", studentTable,
	)
	STUDENT_ADD = fmt.Sprintf(
		`INSERT INTO %s
		(certificate_number, full_name, student_number, course_id, is_present)
		VALUES(:certificate_number, :full_name, :student_number, :course_id, :is_present)
		RETURNING *`,
		studentTable,
	)
	STUDENT_DELETE = fmt.Sprintf(
		"DELETE FROM %s WHERE student_id=$1 RETURNING *",
		studentTable,
	)
	STUDENT_UPDATE = fmt.Sprintf(
		`UPDATE %s
		SET certificate_number=:certificate_number,
		full_name=:full_name, 
		student_number=:student_number,
		course_id=:course_id,
		is_present=:is_present
		WHERE student_id=:student_id RETURNING *`,
		studentTable,
	)
	STUDENT_GET_BY_CARD = fmt.Sprintf(
		`SELECT * FROM %s
		WHERE certificate_number=$1`,
		studentTable,
	)
	STUDENT_UPDATE_PRESENT = fmt.Sprintf(
		`UPDATE %s
		SET is_present=$1
		WHERE student_id=$2
		RETURNING *`,
		studentTable,
	)
)