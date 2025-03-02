FROM python:3.9-alpine3.19

LABEL maintainer="vsseoane"

ENV PYTHONUNBUFFERED=1

RUN apk add --no-cache gcc musl-dev libffi-dev

WORKDIR /app
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

ARG DEV=false
RUN pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt && \
    if [ "$DEV" = "true" ]; then pip install -r /tmp/requirements.dev.txt; fi && \
    rm -rf /tmp

COPY ./app /app

RUN adduser --disabled-password --no-create-home django-user

RUN chown -R django-user /app

EXPOSE 8000

USER django-user
