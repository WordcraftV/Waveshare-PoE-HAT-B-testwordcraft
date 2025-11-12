# Base image Home Assistant pour Raspberry Pi 3B+ (armv7hf)
ARG BUILD_FROM=ghcr.io/home-assistant/armv7hf-base:9.6.3
FROM ${BUILD_FROM}

# Installer dépendances système nécessaires
RUN apk add --no-cache \
      python3 \
      python3-dev \
      py3-pip \
      build-base \
      openjpeg \
      tiff \
      openblas-dev \
      linux-headers

# Créer un virtualenv pour l'addon
RUN python3 -m venv /app/venv

# Mettre à jour pip et installer les packages Python dans le virtualenv
RUN /app/venv/bin/pip install --upgrade pip && \
    /app/venv/bin/pip install pillow numpy RPi.GPIO smbus2

# Copier tout le contenu de l'addon
COPY . /app
WORKDIR /app

# Lancer le script principal via le virtualenv
CMD ["/app/venv/bin/python", "./bin/main.py"]
