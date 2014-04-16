build:
	docker build -t codekoala/pypi .

run:
	sudo mkdir -p /srv/pypi
	sudo cp ./htaccess /srv/pypi/.htaccess
	docker run -t -i --rm -h pypi.local -v /srv/pypi:/srv/pypi:rw -p 8080:80 --name pypi codekoala/pypi

clean:
	docker rmi `docker images -q codekoala/pypi`
