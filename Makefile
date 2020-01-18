build:
	docker build -t bickyeric/mawang:latest .

push:
	docker login -u $DOCKER_USER -p $DOCKER_PASSWORD
	docker push bickyeric/mawang:latest

deploy:
	docker stack deploy config/template.yml
