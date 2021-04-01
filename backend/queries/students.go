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
)