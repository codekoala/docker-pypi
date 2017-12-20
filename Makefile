IMG := codekoala/pypi
TAG := 1.2.1
IMG_TAG := $(IMG):$(TAG)

PYPI ?= /srv/pypi

build:
	docker build --pull --tag $(IMG_TAG) .

run:
	docker run -it --rm \
		--name pypi \
		-h pypi.local \
		-v $(PYPI):/srv/pypi:rw \
		-p 8080:80 \
		$(IMG_TAG)

clean:
	docker rmi `docker images -q $(IMG_TAG)`
