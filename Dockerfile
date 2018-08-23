FROM python:3.6-alpine
COPY requirements.txt .
RUN apk update \
 && apk add git build-base linux-headers zlib-dev jpeg-dev freetype-dev libwebp-dev \
 && pip install -r requirements.txt

FROM python:3.6-alpine
COPY --from=0 /root/.cache /root/.cache
COPY requirements.txt .
RUN set -x \
 && apk update \
 && apk add git zlib jpeg freetype libwebp \
 && ln -sf $(which python) /bin/python \
 && pip install -r requirements.txt \
 && rm -rf /root/.cache \
