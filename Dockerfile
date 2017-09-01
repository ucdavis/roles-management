# FROM ruby:2.4

# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libmagickwand-dev apt-transport-https

# # Install yarn (https://yarnpkg.com/lang/en/docs/install/#linux-tab)
# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# RUN apt-get update && apt-get install -y yarn

# WORKDIR /app

# COPY Gemfile* ./

# RUN bundle install

# COPY . .

# RUN rake assets:precompile

# ENV PORT 3000

# CMD [ "bundle", "exec", "rails", "s", "-b", "0.0.0.0" ]

FROM ruby:2.4-alpine

ENV PATH /root/.yarn/bin:$PATH

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh build-base nodejs tzdata postgresql-dev

RUN apk update \
  && apk add curl bash binutils tar gnupg \
  && rm -rf /var/cache/apk/* \
  && /bin/bash \
  && touch ~/.bashrc \
  && curl -o- -L https://yarnpkg.com/install.sh | bash \
  && apk del curl tar binutils

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
RUN npm rebuild node-sass --force

# Set Rails to run in production
ENV RAILS_ENV production 
ENV RACK_ENV production
ENV RAILS_ROOT /usr/src/app
# Use Rails for static files in public
ENV RAILS_SERVE_STATIC_FILES 1
# You must pass environment variable SECRET_KEY_BASE
ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE $SECRET_KEY_BASE

# Copy the main application.
COPY . ./

# Precompile Rails assets (plus Webpack)
RUN bundle exec rake assets:precompile

# Will run on port 3000 by default
EXPOSE 3000
# Start puma
CMD bundle exec puma -C config/puma.rb