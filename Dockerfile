FROM elixir:alpine

ARG APP_NAME=umbrella_conflict

ENV MIX_ENV=prod REPLACE_OS_VARS=true TERM=xterm

WORKDIR /opt/app

RUN apk update \
    && apk --no-cache --update add build-base \
    && mix local.rebar --force \
    && mix local.hex --force

COPY . .

RUN mix do deps.get, deps.compile, compile

RUN mix release --env=prod --verbose \
    && mv _build/prod/rel/${APP_NAME} /opt/release

FROM alpine:latest

RUN apk update && apk --no-cache --update add bash openssl-dev

ENV PORT=8000 MIX_ENV=prod REPLACE_OS_VARS=true

WORKDIR /opt/app

EXPOSE ${PORT}

COPY --from=0 /opt/release .

CMD ["/opt/app/bin/umbrella_conflict", "foreground"]
