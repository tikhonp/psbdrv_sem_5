package main

import (
	"context"
	"fmt"

	"github.com/tikhonp/psbdrv_sem_5/config"
	"github.com/tikhonp/psbdrv_sem_5/db"
)

func main() {
	cfg, err := config.LoadFromPath(context.Background(), "pkl/local/config.pkl")
	if err != nil {
		panic(err)
	}
	fmt.Print(
		db.DataSourceName(cfg.Db),
	)
}

