package queries

import (
	"fmt"

	"dev.azure.com/u8635137/_git/Jedi/backend/config"
)

const courseTable = config.SchemaName + ".t_course";

var (
	COURSE_GET_ALL = fmt.Sprintf(
		"SELECT * FROM %s", courseTable,
	)
	COURSE_GET_CURRENT = fmt.Sprintf(
		`SELECT * FROM %[1]s
		WHERE %[1]s.date_ending >= $1`,
		courseTable,
		studentTable,
	)
	COURSE_GET_BY_ID = fmt.Sprintf(
		`SELECT * FROM %s
		WHERE course_id=$1`,
		courseTable,
	)
	COURSE_ADD = fmt.Sprintf(
		`INSERT INTO %s
		(course_name, color_theme, date_ending)
		VALUES(:course_name, :color_theme, :date_ending)
		RETURNING *`,
		courseTable,
	)
	COURSE_DELETE = fmt.Sprintf(
		"DELETE FROM %s WHERE course_id=$1 RETURNING *",
		courseTable,
	)
	COURSE_UPDATE = fmt.Sprintf(
		`UPDATE %s
		SET course_name=:course_name, color_theme=:color_theme, date_ending=:date_ending
		WHERE course_id=:course_id RETURNING *`,
		courseTable,
	)
)