# run with:
# docker build -t tammersaleh.com .
# docker run -it -v $(pwd):/app -p 4567:4567 tammersaleh.com
# open http://localhost:4567/

FROM ruby:2.4.1
LABEL maintainer "me@tammersaleh.com"

ENV RUBYOPT="-KU -E utf-8:utf-8"

RUN apt-get update && apt-get install -y build-essential nodejs libgmp3-dev

WORKDIR /app

COPY Gemfile* /app/

RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install --jobs 20 --retry 5

EXPOSE 4567
VOLUME /app

CMD ["bundle", "exec", "middleman", "server", "--bind-address=0.0.0.0"]
