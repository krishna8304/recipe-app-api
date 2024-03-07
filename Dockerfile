FROM python:3.9-alpine3.13
LABEL maintainer="VamsiKrishnaBonthu"

ENV PYTHONBUFFERED 1

COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r requirements-dev.txt ; \
    fi && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user