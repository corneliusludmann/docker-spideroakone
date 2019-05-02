FROM debian

LABEL maintainer "Cornelius A. Ludmann <docker@cornelius-ludmann.de>"

# Install SpiderOakONE
# gnupg is required for the post install script of SpiderOakONE starting with version 6.3.0 ('apt-key')
RUN apt-get update && apt-get install -y \
        curl \
        gnupg \
    && rm -rf /var/lib/apt/lists/*
RUN curl -Ls -o spideroakone.deb "https://spideroak.com/release/spideroak/deb_x64" && \
	dpkg -i spideroakone.deb && \
	rm -f spideroakone.deb

# Create volumes
RUN mkdir -p /spideroakone/.config/SpiderOakONE
VOLUME /spideroakone/.config/SpiderOakONE

# Change workdir
WORKDIR /spideroakone

# Set user ID
# If you want to start SpiderOakONE as root simple set SPIDEROAKONE_UID to an empty string or 0.
ENV SPIDEROAKONE_UID=1000

# Entrypoint
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["--version"]
