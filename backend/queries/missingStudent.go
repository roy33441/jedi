package queries

import (
	"fmt"

	"dev.azure.com/u8635137/_git/Jedi/backend/config"
)

const missingStudentTable = config.SchemaName + ".t_missing_student"

var (
	MISSING_STUDENT_GET_BY_DATE = fmt.Sprintf(
		`SELECT * FROM %s
		WHERE missing_on=$1`,
		missingStudentTable,
	)
)