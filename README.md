[![Docker pulls](https://img.shields.io/docker/pulls/ludmann/spideroakone.svg?maxAge=3600)](https://hub.docker.com/r/ludmann/spideroakone/) [![Docker Stars](https://img.shields.io/docker/stars/ludmann/spideroakone.svg?maxAge=3600)](https://hub.docker.com/r/ludmann/spideroakone/) [![Docker layers](https://images.microbadger.com/badges/image/ludmann/spideroakone.svg)](https://microbadger.com/images/ludmann/spideroakone) ![License](https://img.shields.io/badge/License-MIT-green.svg?maxAge=3600)

# docker-spideroakone
Unofficial Docker container for [SpiderOakONE](https://spideroak.com/).


## Build Docker Image

Simply run `docker build` to build a docker image, e.g.:

	docker build -t ludmann/spideroakone .

By default, a user with name 'spideroakone' and user ID 1000  as well as a group with name 'spideroakone' and group ID 1000 is created and used. You can change this by setting build args, e.g.:


	docker build -t ludmann/spideroakone \
		--build-arg USER=$(whoami) \
		--build-arg GROUP=$(whoami) \
		--build-arg UID=$(id -u) \
		--build-arg GID=$(id -g) \
		.


## Run Docker Container

The docker container has to volumes:
- `/spideroakone/.config/SpiderOakONE`
- `/spideroakone/data`

The following examples assume that you have created to folders in your working directory accessible from the user with the ID specified during the build (user ID 1000 by default):
- `$(pwd)/config` -- The folder where SpiderOakONE stores the config files and cached data.
- `$(pwd)/data` -- The folder where you store your data that should be backed up.

By default, the container prints the SpiderOakONE help:

	docker run --rm -it --name spideroakone -v $(pwd)/data:/spideroakone/data -v $(pwd)/config:/spideroakone/.config/SpiderOakONE ludmann/spideroakone


Each arguments are passed to SpiderOakONE. To launch the SpiderOakONE setup run:

	docker run --rm -it --name spideroakone -v $(pwd)/data:/spideroakone/data -v $(pwd)/config:/spideroakone/.config/SpiderOakONE ludmann/spideroakone --setup=-

After setup, you should add the data folder:

	docker run --rm -it --name spideroakone -v $(pwd)/data:/spideroakone/data -v $(pwd)/config:/spideroakone/.config/SpiderOakONE ludmann/spideroakone --include-dir=/spideroak/data

Start your backup in batchmode:

	docker run --rm -it --name spideroakone -v $(pwd)/data:/spideroakone/data -v $(pwd)/config:/spideroakone/.config/SpiderOakONE ludmann/spideroakone --batchmode

That's it.
