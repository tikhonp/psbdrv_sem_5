all:
	@docker compose up --build

status:
	@goose postgres "$(shell /bin/get_db_string)" -dir=migrations status

up:
	@goose postgres "$(shell /bin/get_db_string)" -dir=migrations up

reset:
	@goose postgres "$(shell /bin/get_db_string)" -dir=migrations reset

pkl_conf:
	@pkl-gen-go pkl/config.pkl --base-path github.com/tikhonp/psbdrv_sem_5

