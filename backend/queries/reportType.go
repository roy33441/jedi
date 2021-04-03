package queries

import (
	"fmt"

	"dev.azure.com/u8635137/_git/Jedi/backend/config"
)

const reportTypeTable = config.SchemaName + ".t_report_type"

var (
	REPORT_TYPE_GET_ALL = fmt.Sprintf(
		"SELECT * FROM %s", reportTypeTable,
	)
	REPORT_TYPE_ADD = fmt.Sprintf(
		`INSERT INTO %s
		(report_type_name)
		VALUES(:report_type_name)
		RETURNING *`,
		reportTypeTable,
	)
	REPORT_TYPE_DELETE = fmt.Sprintf(
		"DELETE FROM %s WHERE report_type_id=$1 RETURNING *",
		reportTypeTable,
	)
	REPORT_TYPE_UPDATE = fmt.Sprintf(
		`UPDATE %s
		SET report_type_name=:report_type_name
		WHERE report_type_id=:report_type_id RETURNING *`,
		reportTypeTable,
	)
	REPORT_TYPE_GET_BY_ID = fmt.Sprintf(
		`SELECT * FROM %s
		WHERE report_type_id=$1`,
		reportTypeTable,
	)
)