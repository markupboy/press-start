FROM ruby:2.7.2-alpine

# Install prereqs
RUN apk --update add alpine-sdk nodejs npm

# Install aws-cli
# RUN \
# 	mkdir -p /aws && \
# 	apk -Uuv add groff less python python-dev py-pip && \
# 	pip install awscli && \
# 	apk --purge -v del py-pip && \
# 	rm /var/cache/apk/*

# Fix timezone
RUN apk add --update tzdata
ENV TZ=America/Denver

# Install gems
COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

# Install yarn and easily get it into PATH with a symlink
# ADD https://github.com/yarnpkg/yarn/releases/download/v1.5.1/yarn-1.5.1.js /usr/local/bin/yarn
# RUN chmod +x /usr/local/bin/yarn

# Set working dir
WORKDIR /app

CMD ["make"]
