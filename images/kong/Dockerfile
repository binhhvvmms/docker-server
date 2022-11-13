ARG DOCKERIZE_VER=0.6.1

FROM jwilder/dockerize:${DOCKERIZE_VER} AS dockerize

FROM kong:2.8.0-alpine

COPY --from=dockerize /usr/local/bin/dockerize /usr/local/bin

ENV KONG_DATABASE="off"
ENV KONG_DECLARATIVE_CONFIG="/usr/local/kong/declarative/kong.yml"
ENV KONG_ADMIN_ACCESS_LOG="/dev/stdout"
ENV KONG_ADMIN_ERROR_LOG="/dev/stderr"
ENV KONG_ADMIN_LISTEN="0.0.0.0:8001"
ENV KONG_PROXY_ACCESS_LOG="/dev/stdout"
ENV KONG_PROXY_ERROR_LOG="/dev/stderr"
ENV KONG_LUA_SSL_TRUSTED_CERTIFICATE="/etc/ssl/certs/ca-certificates.crt"
ENV KONG_PLUGINS="custom-auth,bundled"


COPY ./rootfs/usr/local/kong/declarative/kong.yml /usr/local/kong/declarative/kong.yml
COPY ./plugins /usr/local/share/lua/5.1/kong/plugins
