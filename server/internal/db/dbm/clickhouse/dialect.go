package clickhouse

import (
	"errors"
	"fmt"
	"mayfly-go/internal/db/dbm/dbi"
	"mayfly-go/internal/db/dbm/sqlparser"
	"mayfly-go/internal/db/dbm/sqlparser/pgsql"
	"strings"
)

type ClickHouseDialect struct {
	dc *dbi.DbConn
}

func (cd *ClickHouseDialect) Quoter() dbi.Quoter {
	return dbi.Quoter{
		Prefix:     '`',
		Suffix:     '`',
		IsReserved: dbi.AlwaysReserve,
	}
}

func (cd *ClickHouseDialect) GetDbProgram() (dbi.DbProgram, error) {
	return nil, errors.New("not support db program")
}

func (cd *ClickHouseDialect) GetDumpHelper() dbi.DumpHelper {
	return new(dbi.DefaultDumpHelper)
}

func (cd *ClickHouseDialect) GetSQLParser() sqlparser.SqlParser {
	return new(pgsql.PgsqlParser)
}

func (cd *ClickHouseDialect) CopyTable(copy *dbi.DbCopyTable) error {
	// ClickHouse doesn't support traditional table copying
	// This would need to be implemented with CREATE TABLE ... AS SELECT
	return errors.New("not implemented")
}

func (cd *ClickHouseDialect) GetSQLGenerator() dbi.SQLGenerator {
	return &ClickHouseSQLGenerator{dialect: cd}
}

// ClickHouseSQLGenerator implements the SQLGenerator interface for ClickHouse
type ClickHouseSQLGenerator struct {
	dialect *ClickHouseDialect
}

func (csg *ClickHouseSQLGenerator) GenTableDDL(table dbi.Table, columns []dbi.Column, dropBeforeCreate bool) []string {
	var sqls []string

	if dropBeforeCreate {
		sqls = append(sqls, fmt.Sprintf("DROP TABLE IF EXISTS %s", csg.dialect.Quoter().Quote(table.TableName)))
	}

	var sb strings.Builder
	sb.WriteString(fmt.Sprintf("CREATE TABLE %s (\n", csg.dialect.Quoter().Quote(table.TableName)))

	for i, col := range columns {
		if i > 0 {
			sb.WriteString(",\n")
		}
		sb.WriteString(fmt.Sprintf("  %s %s", csg.dialect.Quoter().Quote(col.ColumnName), col.DataType))

		if col.ColumnComment != "" {
			sb.WriteString(fmt.Sprintf(" COMMENT '%s'", strings.ReplaceAll(col.ColumnComment, "'", "''")))
		}
	}

	sb.WriteString("\n) ENGINE = MergeTree() ORDER BY tuple()")

	if table.TableComment != "" {
		sb.WriteString(fmt.Sprintf(" COMMENT '%s'", strings.ReplaceAll(table.TableComment, "'", "''")))
	}

	sqls = append(sqls, sb.String())
	return sqls
}

func (csg *ClickHouseSQLGenerator) GenIndexDDL(table dbi.Table, indexs []dbi.Index) []string {
	// ClickHouse indexes are typically defined in the CREATE TABLE statement
	// This is a simplified implementation
	return []string{}
}

func (csg *ClickHouseSQLGenerator) GenInsert(tableName string, columns []dbi.Column, values [][]any, duplicateStrategy int) []string {
	if len(values) == 0 {
		return []string{}
	}

	quote := csg.dialect.Quoter().Quote

	// Build column list
	var columnNames []string
	var columnTypes []*dbi.DbDataType

	for _, column := range columns {
		columnNames = append(columnNames, quote(column.ColumnName))
		columnType := dbi.GetDbDataType(DbTypeClickHouse, column.DataType)
		columnTypes = append(columnTypes, columnType)
	}

	// Build values
	var valueRows []string
	for _, row := range values {
		var rowValues []string
		for i, value := range row {
			rowValues = append(rowValues, columnTypes[i].DataType.SQLValue(value))
		}
		valueRows = append(valueRows, fmt.Sprintf("(%s)", strings.Join(rowValues, ", ")))
	}

	sql := fmt.Sprintf("INSERT INTO %s (%s) VALUES %s",
		quote(tableName),
		strings.Join(columnNames, ", "),
		strings.Join(valueRows, ", "))

	return []string{sql}
}
