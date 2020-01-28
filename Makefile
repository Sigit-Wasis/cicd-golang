.PHONY: deploy

export VERSION ?= $(shell git show -q --format=%h)

build:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o bin/api app/api/main.go
	docker build -t bickyeric/mawang:$(VERSION) .

push:
	docker login -u $(DOCKER_USER) -p $(DOCKER_PASSWORD)
	docker push bickyeric/mawang:$(VERSION)

deploy:
	envsubst < deploy/template.yml > deploy.yml
	docker stack deploy --compose-file deploy.yml mawang
