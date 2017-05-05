FROM debian

LABEL maintainer "Cornelius A. Ludmann <docker@cornelius-ludmann.de>"

# Install SpiderOakONE
RUN apt-get update && apt-get install -y \
        curl \
    && rm -rf /var/lib/apt/lists/*
RUN curl -Ls -o spideroakone.deb "https://spideroak.com/getbuild?platform=ubuntu&arch=x86_64" && \
	dpkg -i spideroakone.deb && \
	rm -f spideroakone.deb

# Create group and user
ARG USER=spideroakone
ARG GROUP=spideroakone
ARG UID=1000
ARG GID=1000
RUN groupadd -fg ${GID} ${GROUP} && \
	useradd -r -g ${GID} -u ${UID} -s /bin/bash -d /spideroakone -m ${USER}

# Create volumes
RUN mkdir -p /spideroakone/.config/SpiderOakONE && \
	chown -R ${USER}:${GROUP} /spideroakone/.config && \
	mkdir /spideroakone/data && \
	chown ${USER}:${GROUP} /spideroakone/data
VOLUME /spideroakone/.config/SpiderOakONE
VOLUME /spideroakone/data

# Change user and workdir
USER ${USER}
WORKDIR /spideroakone

# Entrypoint
#ENTRYPOINT ["/bin/bash"]
ENTRYPOINT ["SpiderOakONE"]
CMD ["--help"]
