.PHONY: build install up debug down shell test

build:
	@docker compose build
install:
	@docker compose run --rm --no-deps --entrypoint bundle api install --jobs=3 --retry=5
up:
	@docker compose up -d
debug:
	@docker compose up -d
	@docker attach $$(docker compose ps -q api)
down:
	@docker compose down
start:
	@docker compose start
stop:
	@docker compose stop
sh:
	@docker compose exec api bash
