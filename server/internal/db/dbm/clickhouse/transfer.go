package clickhouse

import (
	"mayfly-go/internal/db/dbm/dbi"
)

// ClickHouseTransfer handles data transfer operations for ClickHouse
type ClickHouseTransfer struct {
	dc *dbi.DbConn
}

// NewClickHouseTransfer creates a new ClickHouseTransfer instance
func NewClickHouseTransfer(conn *dbi.DbConn) *ClickHouseTransfer {
	return &ClickHouseTransfer{dc: conn}
}

// GetInsertSql generates INSERT SQL for transferring data to ClickHouse
func (ct *ClickHouseTransfer) GetInsertSql(tableName string, columns []dbi.Column, values [][]any) []string {
	generator := NewClickHouseSqlGenerator(ct.dc.GetDialect())
	return generator.GenerateInsertSql(tableName, columns, values)
}

// GetBatchInsertSql generates batch INSERT SQL for better performance
func (ct *ClickHouseTransfer) GetBatchInsertSql(tableName string, columns []dbi.Column, values [][]any) string {
	generator := NewClickHouseSqlGenerator(ct.dc.GetDialect())
	return generator.generateBatchInsertSql(tableName, columns, values)
}

// ProcessColumns processes columns for ClickHouse compatibility
func (ct *ClickHouseTransfer) ProcessColumns(columns []dbi.Column) []dbi.Column {
	processed := make([]dbi.Column, len(columns))
	
	for i, col := range columns {
		processed[i] = col
		
		// Convert data types to ClickHouse compatible types
		processed[i].DataType = ct.convertDataType(col.DataType)
		
		// Handle nullable types
		if col.Nullable {
			processed[i].DataType = "Nullable(" + processed[i].DataType + ")"
		}
	}
	
	return processed
}

// convertDataType converts source database data types to ClickHouse data types
func (ct *ClickHouseTransfer) convertDataType(sourceType string) string {
	// This is a simplified mapping. In practice, this would be more comprehensive
	// and might need to be adjusted based on the source database type
	
	switch sourceType {
	case "VARCHAR", "CHAR", "TEXT", "MEDIUMTEXT", "LONGTEXT":
		return "String"
	case "INT", "INTEGER", "MEDIUMINT":
		return "Int32"
	case "BIGINT":
		return "Int64"
	case "SMALLINT":
		return "Int16"
	case "TINYINT":
		return "Int8"
	case "FLOAT":
		return "Float32"
	case "DOUBLE", "DECIMAL", "NUMERIC":
		return "Float64"
	case "DATE":
		return "Date"
	case "DATETIME", "TIMESTAMP":
		return "DateTime"
	case "BOOLEAN", "BOOL":
		return "Bool"
	case "BLOB", "BINARY", "VARBINARY":
		return "String"
	default:
		// For unknown types, default to String
		return "String"
	}
}

// GetTableOptions returns ClickHouse-specific table options for data transfer
func (ct *ClickHouseTransfer) GetTableOptions() map[string]string {
	return map[string]string{
		"engine": "MergeTree()",
		"order_by": "tuple()",
	}
}

// PreTransfer prepares the target ClickHouse database for data transfer
func (ct *ClickHouseTransfer) PreTransfer(tableName string) error {
	// In ClickHouse, we might want to drop the table if it exists before creating it
	// This is optional and depends on the transfer strategy
	
	// For now, we'll just return nil as no specific preparation is needed
	return nil
}

// PostTransfer performs any cleanup or optimization after data transfer
func (ct *ClickHouseTransfer) PostTransfer(tableName string) error {
	// ClickHouse might benefit from optimization after bulk inserts
	// For example, we might want to optimize the table
	
	_, err := ct.dc.Exec("OPTIMIZE TABLE " + ct.dc.GetDialect().Quoter().Quote(tableName) + " FINAL")
	return err
}

// GetDuplicateStrategySupport checks if ClickHouse supports duplicate handling strategies
func (ct *ClickHouseTransfer) GetDuplicateStrategySupport() bool {
	// ClickHouse has limited support for duplicate handling
	// It depends on the table engine being used
	return true
}

// GetBatchSize returns the recommended batch size for ClickHouse inserts
func (ct *ClickHouseTransfer) GetBatchSize() int {
	// ClickHouse benefits from larger batch sizes for better performance
	return 10000
}