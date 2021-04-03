package queries

import (
	"fmt"

	"dev.azure.com/u8635137/_git/Jedi/backend/config"
)

const studentReportTable = config.SchemaName + ".t_student_report"

var (
	STUDENT_REPORT_GET_BY_STUDENT_ID_IN_DAY = fmt.Sprintf(
		`SELECT * FROM %s
		WHERE student_id=$1 AND date_reported=$2`,
		studentReportTable,
	)
	STUDENT_REPORT_DELETE_BY_ID_IN_DAY = fmt.Sprintf(
		`DELETE FROM %s WHERE student_id=$1 AND date_reported=$2
		RETURNING *`,
		studentReportTable,
	)
	STUDENT_REPORT_ADD = fmt.Sprintf(
		`INSERT INTO %s
		(report_type_id, student_id, date_reported)
		VALUES(:report_type_id, :student_id, :date_reported)
		RETURNING *`,
		studentReportTable,
	)
)