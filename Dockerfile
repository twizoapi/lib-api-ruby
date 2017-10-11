FROM ruby:2.5

# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1

WORKDIR /usr/app

# COPY Gemfile twizo.gemspec ./

COPY . .

RUN bundle install && \
gem build twizo.gemspec && \
gem install --local twizo-0.2.0.gem

# COPY . .