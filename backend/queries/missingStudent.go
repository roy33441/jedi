package queries

import (
	"fmt"

	"dev.azure.com/u8635137/_git/Jedi/backend/config"
)

const missingStudentTable = config.SchemaName + ".t_missing_student"
const studentsTable = config.SchemaName + ".t_student"

var (
	MISSING_STUDENT_GET_BY_DATE = fmt.Sprintf(
		`SELECT missing_student_id, student.student_id as student_id, reason_id, missing_on
		 FROM %s missing
		 INNER JOIN %s student ON missing.student_id = student.student_id
		 WHERE missing_on=$1 AND course_id = $2`,
		missingStudentTable,
		studentsTable,
	)
)

var (
	SAVE_MISSING_STUDENT = fmt.Sprintf(`INSERT INTO %s(student_id, reason_id, missing_on)
										VALUES($1, $2, $3)
										RETURNING *`, missingStudentTable)
)

var (
	REMOVE_MISSING_STUDENT = fmt.Sprintf(`DELETE FROM %s WHERE student_id=$1 AND missing_on=$2 RETURNING *`, missingStudentTable)
)
