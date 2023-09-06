FROM ruby:3.2

RUN apt-get update && apt-get install -y npm && npm install -g yarn
RUN curl -s -L https://releases.hoop.dev/release/install-cli.sh | sh

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]