FROM alpine:3

LABEL "com.github.actions.name"="Building i18n files"
LABEL "com.github.actions.description"="Building translation files for the i18n library"
LABEL "com.github.actions.icon"="refresh-ccw"
LABEL "com.github.actions.color"="green"

LABEL version="2.0"
LABEL repository="https://github.com/text-adi/build-lang-action"
LABEL homepage="https://github.com/text-adi"
LABEL maintainer="text-adi <text-adi@github.com>"

RUN apk add --no-cache gettext

WORKDIR /app

COPY docker-entrypoint.sh /app/docker-entrypoint.sh

RUN chmod +x /app/docker-entrypoint.sh

ENTRYPOINT  ["/app/docker-entrypoint.sh"]