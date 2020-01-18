.PHONY: deploy

export VERSION ?= $(shell git show -q --format=%h)

build:
	docker build -t bickyeric/mawang:$(VERSION) .

push:
	docker login -u $(DOCKER_USER) -p $(DOCKER_PASSWORD)
	docker push bickyeric/mawang:$(VERSION)

deploy:
	docker stack deploy --compose-file deploy/template.yml mawang
