# https://cloud.google.com/community/tutorials/elixir-phoenix-on-kubernetes-google-container-engine
FROM elixir:alpine
ARG app_name=hello
ARG phoenix_subdir=.
ARG build_env=prod
ENV MIX_ENV=${build_env} TERM=xterm
ENV PORT=8080
EXPOSE ${PORT}
WORKDIR /opt/app
RUN apk update \
    && apk --no-cache --update add nodejs nodejs-npm \
    && mix local.rebar --force \
    && mix local.hex --force
COPY . .
RUN mix do deps.get, compile
RUN cd ${phoenix_subdir}/assets \
    && npm install \
    && ./node_modules/webpack/bin/webpack.js --mode production \
    && cd .. \
    && mix phx.digest
RUN mix release ${app_name} \
    && mv _build/${build_env}/rel/${app_name} /opt/release \
    && mv /opt/release/bin/${app_name} /opt/release/bin/start_server
#FROM alpine:latest
#ARG project_id
#RUN apk update \
#    && apk --no-cache --update add bash ca-certificates openssl-dev \
#    && mkdir -p /usr/local/bin \
#    && wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 \
#        -O /usr/local/bin/cloud_sql_proxy \
#    && chmod +x /usr/local/bin/cloud_sql_proxy \
#    && mkdir -p /tmp/cloudsql
# ENV PORT=8080 GCLOUD_PROJECT_ID=${project_id} REPLACE_OS_VARS=true
# EXPOSE ${PORT}
# WORKDIR /opt/app
# COPY --from=0 /opt/release .
# CMD (/usr/local/bin/cloud_sql_proxy \
#       -projects=${GCLOUD_PROJECT_ID} -dir=/tmp/cloudsql &); \
#     exec /opt/app/bin/start_server start
