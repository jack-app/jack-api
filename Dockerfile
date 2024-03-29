FROM ruby:2.5.0

RUN apt-get update && apt-get install -y build-essential libpq-dev postgresql-client

RUN mkdir /app
WORKDIR /app
