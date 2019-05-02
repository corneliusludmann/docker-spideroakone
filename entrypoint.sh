#!/usr/bin/env bash

set -e

if [[ -z "$SPIDEROAKONE_UID" ]] || [[ "$SPIDEROAKONE_UID" == "0" ]]; then
	echo 'INFO: Environment variable $UID is not set. Running SpiderOakONE as root.'
	echo ""
	SpiderOakONE "$@"
else

	SPIDEROAKONE_USER=${SPIDEROAKONE_USER:-spideroakone}
	SPIDEROAKONE_GROUP=${SPIDEROAKONE_GROUP:-spideroakone}
	SPIDEROAKONE_GID=${SPIDEROAKONE_GID:-$SPIDEROAKONE_UID}

	EXISTING_USER_WITH_UID=$(getent passwd ${SPIDEROAKONE_UID} | cut -d: -f1)

	if [[ -z "$EXISTING_USER_WITH_UID" ]]; then
		# There is no user with uid $SPIDEROAKONE_UID. We gonna create one.

		chown -R ${SPIDEROAKONE_UID}:${SPIDEROAKONE_GID} /spideroakone/

		addgroup \
			--gid ${SPIDEROAKONE_GID} \
			--quiet \
			${SPIDEROAKONE_GROUP}

		adduser \
			--home /spideroakone \
			--shell /bin/bash \
			--uid ${SPIDEROAKONE_UID} \
			--gid ${SPIDEROAKONE_GID} \
			--disabled-password \
			--gecos "" \
			--quiet \
			${SPIDEROAKONE_USER}

	else
		if [[ "$EXISTING_USER_WITH_UID" != "$SPIDEROAKONE_USER" ]]; then
			echo "ERROR: There is another user called '${EXISTING_USER_WITH_UID}' with uid ${SPIDEROAKONE_UID}."
			exit 1
		fi
	fi

	echo "INFO: Running SpiderOakONE as user '${SPIDEROAKONE_USER}' (uid=${SPIDEROAKONE_UID})."
	echo ""
	runuser \
		--command "SpiderOakONE $*" \
		- \
		${SPIDEROAKONE_USER}
fi
