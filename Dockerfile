FROM alpine:3.17
LABEL authors="text-adi"

ENV DIR='*'
ENV DELETE_FILE_MO=1

RUN apk add --no-cache gettext

WORKDIR /app

COPY script/docker-entrypoint.sh /app/docker-entrypoint.sh

RUN chmod +x /app/docker-entrypoint.sh

ENTRYPOINT  ["/app/docker-entrypoint.sh"]