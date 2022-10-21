FROM alpine:3.10
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
RUN apk add jq
RUN apk add openjdk11
ENTRYPOINT ["/entrypoint.sh"]