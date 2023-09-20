FROM ruby:2.7-alpine

ENV PATH /root/.yarn/bin:$PATH

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh build-base nodejs tzdata mysql-dev

RUN apk update \
  && apk add curl bash binutils tar gnupg \
  && rm -rf /var/cache/apk/* \
  && /bin/bash \
  && touch ~/.bashrc \
  && curl -o- -L https://yarnpkg.com/install.sh | bash \
  && apk del tar binutils

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
WORKDIR /usr/src/app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install -j "$(getconf _NPROCESSORS_ONLN)" --retry 5 --without development test

# Copy dependencies for Node.js and instance the packages.
# Again, being separate means this will cache.
COPY package.json yarn.lock ./
RUN yarn install
# RUN npm rebuild node-sass --force

ARG RAILS_ENV=production
ENV RAILS_ENV $RAILS_ENV

ARG RACK_ENV=production
ENV RACK_ENV $RACK_ENV

ENV RAILS_ROOT /usr/src/app

# Use Rails for static files in public
ENV RAILS_SERVE_STATIC_FILES 0

# Set Rack::Timeout values
ENV RACK_TIMEOUT_SERVICE_TIMEOUT 120

# Log to STDOUT
ENV RAILS_LOG_TO_STDOUT 1

ARG SECRET_KEY_BASE=changeme
ENV SECRET_KEY_BASE $SECRET_KEY_BASE

ARG DW_URL
ENV DW_URL $DW_URL
ARG DW_TOKEN
ENV DW_TOKEN $DW_TOKEN

ARG DB_NAME
ENV DB_NAME $DB_NAME
ARG DB_USER
ENV DB_USER $DB_USER
ARG DB_PASSWORD
ENV DB_PASSWORD $DB_PASSWORD
ARG DB_HOST
ENV DB_HOST $DB_HOST

ARG RAILS_MAX_THREADS=8
ENV RAILS_MAX_THREADS $RAILS_MAX_THREADS

# SMTP settings
ARG SMTP_HOST
ENV SMTP_HOST $SMTP_HOST
ARG SMTP_FROM_ADDRESS
ENV SMTP_FROM_ADDRESS $SMTP_FROM_ADDRESS
ARG SMTP_USERNAME
ENV SMTP_USERNAME $SMTP_USERNAME
ARG SMTP_PASSWORD
ENV SMTP_PASSWORD $SMTP_PASSWORD

# CAS settings
ARG CAS_URL
ENV CAS_URL $CAS_URL

# DynamoDB settings
ARG DYNAMODB_REGION
ENV DYNAMODB_REGION $DYNAMODB_REGION
ARG DYNAMODB_ENDPOINT
ENV DYNAMODB_ENDPOINT $DYNAMODB_ENDPOINT
ARG DYNAMODB_ACTIVITY_LOG_TABLE
ENV DYNAMODB_ACTIVITY_LOG_TABLE $DYNAMODB_ACTIVITY_LOG_TABLE
ARG DYNAMODB_AWS_ACCESS_KEY
ENV DYNAMODB_AWS_ACCESS_KEY $DYNAMODB_AWS_ACCESS_KEY
ARG DYNAMODB_AWS_SECRET_KEY
ENV DYNAMODB_AWS_SECRET_KEY $DYNAMODB_AWS_SECRET_KEY

# AD settings
ARG AD_USER
ENV AD_USER $AD_USER
ARG AD_PASS
ENV AD_PASS $AD_PASS
ARG AD_PEOPLE_HOST
ENV AD_PEOPLE_HOST $AD_PEOPLE_HOST
ARG AD_PEOPLE_BASE
ENV AD_PEOPLE_BASE $AD_PEOPLE_BASE
ARG AD_GROUPS_HOST
ENV AD_GROUPS_HOST $AD_GROUPS_HOST
ARG AD_GROUPS_BASE
ENV AD_GROUPS_BASE $AD_GROUPS_BASE
ARG AD_GROUPS_PORT
ENV AD_GROUPS_PORT $AD_GROUPS_PORT

ARG RM_ENDPOINT_HOST
ENV RM_ENDPOINT_HOST $RM_ENDPOINT_HOST
ARG RM_ENDPOINT_USER
ENV RM_ENDPOINT_USER $RM_ENDPOINT_USER
ARG RM_ENDPOINT_PASS
ENV RM_ENDPOINT_PASS $RM_ENDPOINT_PASS

RUN mkdir log && touch log/delayed_job.log

# Copy the main application.
COPY . ./
RUN curl https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem -o rds-combined-ca-bundle.pem -s

# Precompile Rails assets (plus Webpack)
RUN bundle exec rake assets:precompile

# Will run on port 3000 by default
EXPOSE 3000
# Start puma
CMD bundle exec puma -C config/puma.rb
