package main

import (
	"context"
	"flag"
	"fmt"

	"github.com/tikhonp/psbdrv_sem_5/config"
	"github.com/tikhonp/psbdrv_sem_5/db"
)

func main() {
	cfg, err := config.LoadFromPath(context.Background(), "config.pkl")
	if err != nil {
		panic(err)
	}

    filePath := flag.String("file", "", "path to sql file")
    flag.Parse()
    if filePath == nil || *filePath == "" {
        fmt.Println("file path is required")
        return
    }

    db.MustConnect(cfg.Db)
   
    err = db.ExecuteFile(*filePath)
    if err != nil {
        panic(err)
    }
}

