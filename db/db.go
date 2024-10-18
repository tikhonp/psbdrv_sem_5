package db

import (
	"bytes"
	"fmt"
	"os"

	"github.com/jmoiron/sqlx"
	_ "github.com/lib/pq"
	"github.com/tikhonp/psbdrv_sem_5/config"
)

// db is a global database.
//
// Yes, im dumb and i use global varibles for db.
// It's my second project in go, i think you can forgive me.
var db *sqlx.DB

func DataSourceName(cfg *config.Database) string {
	return fmt.Sprintf("user=%s dbname=%s sslmode=disable password=%s host=%s", cfg.User, cfg.Dbname, cfg.Password, cfg.Host)
}

// MustConnect creates a new in-memory SQLite database and initializes it with the schema.
func MustConnect(cfg *config.Database) {
	db = sqlx.MustConnect("postgres", DataSourceName(cfg))
}

func ExecuteFile(path string) error {
	f, err := os.Open(path)
	if err != nil {
		return err
	}
	defer f.Close()

	buf := new(bytes.Buffer)
	buf.ReadFrom(f)

	_, err = db.Exec(buf.String())
	return err
}

