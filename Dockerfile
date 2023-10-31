FROM ruby:3.2.1-alpine

ARG WORKDIR
ARG RUNTIME_PACKAGES="nodejs tzdata postgresql-dev postgresql git"
ARG DEV_PACKAGES="build-base curl-dev"

ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo

ENV AWS_ACCESS_KEY_ID=AKIAYAWUQSFDRSWEZBMC
ENV AWS_SECRET_ACCESS_KEY=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
ENV AWS_S3_BUCKET=ap-northeast-3

WORKDIR ${HOME}

COPY Gemfile* ./

RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${RUNTIME_PACKAGES} && \
    apk add --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
    bundle install -j4 && \
    apk del build-dependencies
RUN apk add --no-cache gcompat
RUN apk update
RUN apk add vim

COPY . .

CMD bundle exec rails server -b 0.0.0.0