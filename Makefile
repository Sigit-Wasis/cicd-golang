.PHONY: deploy

export VERSION ?= $(shell git show -q --format=%h)

build:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o bin/api app/api/main.go
	docker build -t wasis/cicd-golang:$(VERSION) .

test:
	go test ./... -cover -count=1

push:
	docker push wasis/cicd-golang:$(VERSION)

deploy:
	envsubst < deploy/template.yml > deploy.yml
	docker stack deploy --compose-file deploy.yml cicd-golang
