FROM ruby:2.7.2-alpine

# Install prereqs
RUN apk --update add alpine-sdk nodejs npm

# Install aws-cli
RUN apk add --no-cache \
  python3 \
  py3-pip \
  && pip3 install --upgrade pip \
  && pip3 install \
  awscli \
  && rm -rf /var/cache/apk/*

# Fix timezone
RUN apk add --update tzdata
ENV TZ=America/Denver

# Install gems
COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

# Set working dir
WORKDIR /app

CMD ["make"]
