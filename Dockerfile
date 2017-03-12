# Based on http://blog.codeship.com/running-rails-development-environment-docker/
#

FROM ruby:2.3.3-slim
MAINTAINER mbajur@gmail.com

RUN apt-get update && apt-get install -y \
  build-essential nodejs locales

# Set locales
RUN locale-gen en_US.UTF-8 && localedef -i en_US -f UTF-8 en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p /app
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock ./

RUN gem install bundler
RUN bundle install --jobs 20 --retry 5 --without="development,test"

# Copy the main application.
COPY . ./

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 9292

ENV JEKYLL_CONFIG_FILE _config_production.yml

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["bundle", "exec", "rackup", "config.ru", "-o", "0.0.0.0", "-p", "9292"]

# Define a healthcheck
HEALTHCHECK CMD curl --fail http://0.0.0.0:9292/ || exit 1