-- ClickHouse metadata SQL queries

-- Get database names
SELECT name FROM system.databases 
WHERE name NOT IN ('system', 'information_schema', 'INFORMATION_SCHEMA') 
ORDER BY name;

-- Get table names
SELECT name, engine, comment 
FROM system.tables 
WHERE database = '{{.Database}}' 
ORDER BY name;

-- Get table columns
SELECT 
    name,
    type,
    '' as column_comment,
    0 as is_nullable,
    0 as is_primary_key,
    '' as column_default,
    0 as is_auto_increment
FROM system.columns 
WHERE database = '{{.Database}}' AND table = '{{.Table}}' 
ORDER BY position;

-- Get table indexes (simplified for ClickHouse)
SELECT 
    name,
    type,
    '' as comment
FROM system.indexes 
WHERE database = '{{.Database}}' AND table = '{{.Table}}';

-- Get primary key information
SELECT primary_key 
FROM system.tables 
WHERE database = '{{.Database}}' AND name = '{{.Table}}';

-- Get create table statement
SELECT create_table_query 
FROM system.tables 
WHERE database = '{{.Database}}' AND name = '{{.Table}}';

-- Get database server information
SELECT 
    version() as version,
    'ClickHouse' as database,
    '' as uptime;

-- Get database size
SELECT sum(bytes) as size 
FROM system.parts 
WHERE database = '{{.Database}}';

-- Get table row count
SELECT sum(rows) as row_count 
FROM system.parts 
WHERE database = '{{.Database}}' AND table = '{{.Table}}';