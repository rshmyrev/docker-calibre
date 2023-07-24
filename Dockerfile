FROM debian:bookworm-slim
LABEL maintainer="rshmyrev <rshmyrev@gmail.com>"

# Install Calibre
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends calibre \
 && rm -rf /var/lib/apt/lists/*

# Set XDG Base Directory
ENV USER=user \
    HOME=/home/user \
    XDG_CACHE_HOME=/home/user/.cache \
    XDG_CONFIG_HOME=/home/user/.config \
    XDG_DATA_HOME=/home/user/.local/share \
    XDG_STATE_HOME=/home/user/.local/state \
    XDG_RUNTIME_DIR=/run/user/1000

# Create a user and directories
RUN mkdir -p /config /library ${HOME} ${XDG_CONFIG_HOME} \
 && ln -s /config  ${XDG_CONFIG_HOME}/calibre \
 && ln -s /library ${HOME}/"Calibre Library" \
 && useradd -d ${HOME} -G audio,video ${USER} \
 && chown -R ${USER}:${USER} /config /library ${HOME} ${XDG_CONFIG_HOME}

VOLUME ["/config", "/library"]
USER user
WORKDIR /home/user
ENTRYPOINT ["/usr/bin/calibre"]
