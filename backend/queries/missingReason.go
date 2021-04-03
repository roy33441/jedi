package queries

import (
	"fmt"

	"dev.azure.com/u8635137/_git/Jedi/backend/config"
)

const missingReasonTable = config.SchemaName + ".t_missing_reason"

var (
	MISSING_REASON_GET_ALL = fmt.Sprintf(
		"SELECT * FROM %s", missingReasonTable,
	)
	MISSING_REASON_ADD = fmt.Sprintf(
		`INSERT INTO %s
		(reason_text)
		VALUES(:reason_text)
		RETURNING *`,
		missingReasonTable,
	)
	MISSING_REASON_DELETE = fmt.Sprintf(
		"DELETE FROM %s WHERE reason_id=$1 RETURNING *",
		missingReasonTable,
	)
	MISSING_REASON_UPDATE = fmt.Sprintf(
		`UPDATE %s
		SET reason_text=:reason_text
		WHERE reason_id=:reason_id RETURNING *`,
		missingReasonTable,
	)
	MISSING_REASON_GET_BY_ID = fmt.Sprintf(
		`SELECT * FROM %s
		WHERE reason_id=$1`,
		missingReasonTable,
	)
)