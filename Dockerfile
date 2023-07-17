FROM ruby:3.0.4

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libssl-dev \
    zlib1g-dev \
    postgresql-client \
    nodejs

RUN apt-get install -y libpq-dev

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null && \
    echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

RUN gem install mailcatcher --no-document

COPY Gemfile Gemfile.lock /app/
WORKDIR /app

RUN gem install bundler
RUN bundle install --jobs 4 --retry 3

COPY . /app

RUN npm install

RUN yarn

EXPOSE 3000

CMD ["bash", "-c", "redis-server & mailcatcher --ip 0.0.0.0 && bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0 && bundle exec sidekiq && bundle exec rails db:seed"]