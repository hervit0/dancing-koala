# Run it:
# docker build --no-cache -t dancing-koala .
# docker run -it --rm -p 8080:8080 dancing-koala

FROM elixir:1.6.0-alpine
ARG APP_NAME=dancing-koala
ARG PHOENIX_SUBDIR=.
ENV MIX_ENV=prod REPLACE_OS_VARS=true TERM=xterm
WORKDIR /opt/app
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force
RUN apk update \
    && apk --no-cache --update add nodejs nodejs-npm \
    && mix local.rebar --force \
    && mix local.hex --force
ADD . .
RUN mix do deps.get, deps.compile, compile
RUN cd ${PHOENIX_SUBDIR}/assets \
    && npm install \
    && ./node_modules/brunch/bin/brunch build -p \
    && cd .. \
    && mix phx.digest
CMD mix do ecto.create, ecto.migrate, phx.server

# Using distillery for realase
# RUN mix release --env=prod --verbose \
#     && mv _build/prod/rel/${APP_NAME} /opt/release \
#     && mv /opt/release/bin/${APP_NAME} /opt/release/bin/start_server
# FROM alpine:latest
# RUN apk update && apk --no-cache --update add bash openssl-dev
# ENV PORT=8080 MIX_ENV=prod REPLACE_OS_VARS=true
# WORKDIR /opt/app
# EXPOSE ${PORT}
# COPY --from=0 /opt/release .
# CMD ["/opt/app/bin/start_server", "foreground"]