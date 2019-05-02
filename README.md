[![Docker pulls](https://img.shields.io/docker/pulls/ludmann/spideroakone.svg?maxAge=3600)](https://hub.docker.com/r/ludmann/spideroakone/) [![Docker Stars](https://img.shields.io/docker/stars/ludmann/spideroakone.svg?maxAge=3600)](https://hub.docker.com/r/ludmann/spideroakone/) [![Docker layers](https://images.microbadger.com/badges/image/ludmann/spideroakone.svg)](https://microbadger.com/images/ludmann/spideroakone) ![License](https://img.shields.io/badge/License-MIT-green.svg?maxAge=3600)

# docker-spideroakone
Unofficial Docker container for [SpiderOakONE](https://spideroak.com/).


## Run Docker Container

The docker container has the following volume:
- `/spideroakone/.config/SpiderOakONE`

By default, the container prints the SpiderOakONE version (`SpiderOakONE --version`). The argument is passed to `SpiderOakONE`. To launch the SpiderOakONE setup run:

	docker run --rm -it \
		-v $(pwd)/config:/spideroakone/.config/SpiderOakONE \
		ludmann/spideroakone --setup=-

After setup you should add the folder for the backup, e. g.:

	docker run --rm -it \
		-v $(pwd)/config:/spideroakone/.config/SpiderOakONE \
		-v $(pwd)/mydata:/backup \
		ludmann/spideroakone --include-dir=/backup

Start your backup in batchmode (will exit if ready):

	docker run --rm -it \
		-v $(pwd)/config:/spideroakone/.config/SpiderOakONE \
		-v $(pwd)/mydata:/backup \
		ludmann/spideroakone --batchmode

... or in headless mode (will run forever):

	docker run --rm -it \
		-v $(pwd)/config:/spideroakone/.config/SpiderOakONE \
		-v $(pwd)/mydata:/backup \
		ludmann/spideroakone --headless

## Change user

By default, SpiderOakONE will be started as user `spideroakone` with UID 1000 and GID 1000. You can change this by setting the following environment variables:

Variable | Default Value | Description
---------|---------------|------------
`SPIDEROAKONE_UID` | 1000 | The UID (user id) of the user that should be used to run SpiderOakONE. If not set, empty or set to 0, root user is used and all other variables are ignored.
`SPIDEROAKONE_GID` | `$SPIDEROAKONE_UID` | The GID (groud id).
`SPIDEROAKONE_USER` | `spideroakone` | The user name.
`SPIDEROAKONE_GROUP` | `spideroakone` | The group name.

- If a user with same UID and user name exists, this user will be used (no matter which group / GID the user has).
- If a user with same UID and different user name exists, the container terminates with an error.

Example how to run SpiderOakONE as root:

	docker run --rm -it \
		-e SPIDEROAKONE_UID=0 \
		-v $(pwd)/config:/spideroakone/.config/SpiderOakONE \
		ludmann/spideroakone --setup=-

