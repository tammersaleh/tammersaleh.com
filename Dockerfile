# run with:
# docker build -t tammersaleh.com .
# docker run -it -v $(pwd):/app -p 4567:4567 tammersaleh.com
# open http://localhost:4567/

FROM ruby:2.1 
LABEL maintainer "me@tammersaleh.com"

RUN apt-get update && apt-get install -y build-essential nodejs libgmp3-dev

WORKDIR /app

RUN gem install bundler 

ADD Gemfile /app
ADD Gemfile.lock /app

RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install --jobs 20 --retry 5

EXPOSE 4567
VOLUME /app

CMD ["bundle", "exec", "middleman", "server", "-h", "0.0.0.0"]
