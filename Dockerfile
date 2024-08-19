FROM ruby:3.3.4

RUN apt-get update -qq && apt-get install -y \
  curl \
  build-essential \
  git \
  libjemalloc2 \
  libvips \
  libpq-dev \
  libyaml-dev \
  nodejs \
  yarn \
  pkg-config \
  postgresql-client \
  libgmp-dev \
  libssl-dev \
  libreadline-dev \
  zlib1g-dev \
  libonig-dev && \
  rm -rf /var/lib/apt/lists /var/cache/apt/archives

ENV RAILS_ENV=development
ENV BUNDLE_PATH=/gems

WORKDIR /app

RUN gem install bundler
RUN gem install rails
RUN gem install rspec-rails

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

COPY . .

RUN bundle exec bootsnap precompile app/ lib/

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]