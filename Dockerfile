FROM ruby:2.5.0

RUN apt-get update && apt-get install -y build-essential libpq-dev postgresql-client
RUN gem install rails -v "6.0.0"
RUN mkdir /app
WORKDIR /app
