module mayfly-go

go 1.24

require (
	gitee.com/chunanyong/dm v1.8.20
	gitee.com/liuzongyang/libpq v1.10.11
	github.com/antlr4-go/antlr/v4 v4.13.1
	github.com/emirpasic/gods v1.18.1
	github.com/gin-gonic/gin v1.10.1
	github.com/glebarez/sqlite v1.11.0
	github.com/go-gormigrate/gormigrate/v2 v2.1.4
	github.com/go-ldap/ldap/v3 v3.4.8
	github.com/go-playground/locales v0.14.1
	github.com/go-playground/universal-translator v0.18.1
	github.com/go-playground/validator/v10 v10.26.0
	github.com/go-sql-driver/mysql v1.9.2
	github.com/golang-jwt/jwt/v5 v5.2.2
	github.com/google/uuid v1.6.0
	github.com/gorilla/websocket v1.5.3
	github.com/lionsoul2014/ip2region/binding/golang v0.0.0-20250508043914-ed57fa5c5274
	github.com/may-fly/cast v1.7.1
	github.com/microsoft/go-mssqldb v1.8.0
	github.com/mojocn/base64Captcha v1.3.8 // 验证码
	github.com/pkg/errors v0.9.1
	github.com/pkg/sftp v1.13.9
	github.com/pquerna/otp v1.5.0
	github.com/redis/go-redis/v9 v9.10.0
	github.com/robfig/cron/v3 v3.0.1 // 定时任务
	github.com/sijms/go-ora/v2 v2.8.24
	github.com/stretchr/testify v1.10.0
	github.com/tidwall/gjson v1.18.0
	github.com/veops/go-ansiterm v0.0.5
	go.mongodb.org/mongo-driver v1.16.0 // mongo
	golang.org/x/crypto v0.40.0 // ssh
	golang.org/x/oauth2 v0.30.0
	golang.org/x/sync v0.16.0
	gopkg.in/natefinch/lumberjack.v2 v2.2.1
	gopkg.in/yaml.v3 v3.0.1
	// gorm
	gorm.io/driver/mysql v1.6.0
	gorm.io/gorm v1.30.0
)

require github.com/ClickHouse/clickhouse-go/v2 v2.40.1

require (
	filippo.io/edwards25519 v1.1.0 // indirect
	github.com/Azure/go-ntlmssp v0.0.0-20221128193559-754e69321358 // indirect
	github.com/ClickHouse/ch-go v0.67.0 // indirect
	github.com/andybalholm/brotli v1.2.0 // indirect
	github.com/boombuler/barcode v1.0.1-0.20190219062509-6c824513bacc // indirect
	github.com/bytedance/sonic v1.11.6 // indirect
	github.com/bytedance/sonic/loader v0.1.1 // indirect
	github.com/cespare/xxhash/v2 v2.3.0 // indirect
	github.com/cloudwego/base64x v0.1.4 // indirect
	github.com/cloudwego/iasm v0.2.0 // indirect
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/dgryski/go-rendezvous v0.0.0-20200823014737-9f7001d12a5f // indirect
	github.com/dustin/go-humanize v1.0.1 // indirect
	github.com/gabriel-vasile/mimetype v1.4.8 // indirect
	github.com/gin-contrib/sse v0.1.0 // indirect
	github.com/glebarez/go-sqlite v1.21.2 // indirect
	github.com/go-asn1-ber/asn1-ber v1.5.5 // indirect
	github.com/go-faster/city v1.0.1 // indirect
	github.com/go-faster/errors v0.7.1 // indirect
	github.com/goccy/go-json v0.10.2 // indirect
	github.com/golang-sql/civil v0.0.0-20220223132316-b832511892a9 // indirect
	github.com/golang-sql/sqlexp v0.1.0 // indirect
	github.com/golang/freetype v0.0.0-20170609003504-e2365dfdc4a0 // indirect
	github.com/golang/snappy v0.0.4 // indirect
	github.com/jinzhu/inflection v1.0.0 // indirect
	github.com/jinzhu/now v1.1.5 // indirect
	github.com/json-iterator/go v1.1.12 // indirect
	github.com/klauspost/compress v1.18.0 // indirect
	github.com/klauspost/cpuid/v2 v2.2.7 // indirect
	github.com/kr/fs v0.1.0 // indirect
	github.com/leodido/go-urn v1.4.0 // indirect
	github.com/mattn/go-isatty v0.0.20 // indirect
	github.com/mattn/go-runewidth v0.0.16 // indirect
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/modern-go/reflect2 v1.0.2 // indirect
	github.com/montanaflynn/stats v0.7.1 // indirect
	github.com/paulmach/orb v0.11.1 // indirect
	github.com/pelletier/go-toml/v2 v2.2.2 // indirect
	github.com/pierrec/lz4/v4 v4.1.22 // indirect
	github.com/pmezard/go-difflib v1.0.0 // indirect
	github.com/remyoudompheng/bigfft v0.0.0-20230129092748-24d4a6f8daec // indirect
	github.com/rivo/uniseg v0.4.7 // indirect
	github.com/rogpeppe/go-internal v1.11.0 // indirect
	github.com/segmentio/asm v1.2.0 // indirect
	github.com/shopspring/decimal v1.4.0 // indirect
	github.com/tidwall/match v1.1.1 // indirect
	github.com/tidwall/pretty v1.2.1 // indirect
	github.com/tjfoc/gmsm v1.4.1 // indirect
	github.com/twitchyliquid64/golang-asm v0.15.1 // indirect
	github.com/ugorji/go/codec v1.2.12 // indirect
	github.com/xdg-go/pbkdf2 v1.0.0 // indirect
	github.com/xdg-go/scram v1.1.2 // indirect
	github.com/xdg-go/stringprep v1.0.4 // indirect
	github.com/youmark/pkcs8 v0.0.0-20181117223130-1be2e3e5546d // indirect
	go.opentelemetry.io/otel v1.37.0 // indirect
	go.opentelemetry.io/otel/trace v1.37.0 // indirect
	golang.org/x/arch v0.14.0 // indirect
	golang.org/x/exp v0.0.0-20250210185358-939b2ce775ac // indirect
	golang.org/x/image v0.23.0 // indirect
	golang.org/x/net v0.42.0 // indirect
	golang.org/x/sys v0.34.0 // indirect
	golang.org/x/text v0.27.0 // indirect
	google.golang.org/protobuf v1.34.1 // indirect
	modernc.org/libc v1.22.5 // indirect
	modernc.org/mathutil v1.5.0 // indirect
	modernc.org/memory v1.5.0 // indirect
	modernc.org/sqlite v1.23.1 // indirect
)
