ARG BUILD_FROM
ARG BUILD_FROM=ghcr.io/home-assistant/armv7hf-base:9.6.3
FROM ${BUILD_FROM}

# Install requirements for add-on
RUN \
  apk add --no-cache \
    python3 \
    openjpeg \
    tiff \
    openblas-dev \
    py3-pip && \
  pip install --no-cache-dir pillow && \
  pip install --no-cache-dir numpy && \
  pip3 install --no-cache-dir RPi.GPIO && \
  pip3 install --no-cache-dir smbus

COPY . /app

WORKDIR /app

CMD ["python", "./bin/main.py"]

