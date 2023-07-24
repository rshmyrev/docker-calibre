# Calibre Docker

This repository contains a Docker image for running [Calibre](https://calibre-ebook.com/), an open-source e-book manager.

## Configuration

The Calibre Docker container can be configured using environment variables and volumes.

### Environment Variables

- `DISPLAY`: X11 display server connection string (e.g., `unix$DISPLAY`).
- `LOGNAME`: Your username (used for the Kindle volume mapping). Optional.

### Volumes

- `/tmp/.X11-unix:/tmp/.X11-unix:ro`: X11 socket for display forwarding.
- `${HOME}/.config/calibre:/config`: Calibre configuration directory.
- `${HOME}/"Calibre Library":/library`: Calibre library directory.
- `/media/${LOGNAME}/Kindle:/media/user/Kindle`: Kindle device mount point. Optional.

## Usage

### Docker run

```bash
docker run -d \
  --name calibre \
  -e DISPLAY=unix${DISPLAY} \
  --device /dev/dri:/dev/dri \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v ${HOME}/.config/calibre:/config \
  -v ${HOME}/"Calibre Library":/library \
  -v /media/${LOGNAME}/Kindle:/media/user/Kindle \
  rshmyrev/calibre
```

### Docker compose

```bash
docker compose up -d
```
