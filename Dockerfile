FROM ruby:2.3.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libxml2-dev libxslt1-dev aptitude

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD Gemfile /usr/src/app/
ADD Gemfile.lock /usr/src/app/
RUN bundle install

ADD . /usr/src/app

RUN rm -rf node_modules
RUN rm -rf bower_components
RUN curl -sL https://deb.nodesource.com/setup | bash -

RUN apt-get install -y nodejs
RUN npm -v
RUN npm -g install npm@latest
RUN npm -v
RUN npm install -g n
RUN n latest

RUN apt-get install -y nodejs
RUN aptitude install -y npm
RUN npm install -g bower
RUN bower install --allow-root
RUN npm install
RUN node_modules/.bin/gulp build
RUN NODE_ENV=production node gulp/server.js

ENV RAILS_ENV production

EXPOSE 8080
ENTRYPOINT bin/start_server.sh
