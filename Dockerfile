FROM python:3.11-alpine AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --prefix=/install -r requirements.txt


FROM python:3.11-alpine

LABEL "com.github.actions.name"="Building i18n files"
LABEL "com.github.actions.description"="Building translation files for the i18n library"
LABEL "com.github.actions.icon"="refresh-ccw"
LABEL "com.github.actions.color"="green"

LABEL version="1"
LABEL repository="https://github.com/text-adi/build-lang-action"
LABEL homepage="https://github.com/text-adi"
LABEL maintainer="text-adi <text-adi@github.com>"

WORKDIR /code

COPY script /script

COPY --from=builder /install /usr/local/

CMD ["python","/script/main.py"]