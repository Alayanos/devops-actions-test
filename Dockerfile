# Stage 1: Builder
FROM golang:latest as builder

RUN mkdir -p /build/atv
ADD . /build /build
WORKDIR /build/atv

ENV GOPATH=/build

# build logic
ARG ARG_BUILD=release-scratch
RUN make $ARG_BUILD

# Stage 2: Final image
FROM alpine

RUN apk update
RUN apk upgrade
RUN apk add ca-certificates && update-ca-certificates
RUN apk add --update tzdata


RUN adduser -S -D -H -h /app appuser
USER appuser

# Real copy from builder
COPY --from=builder /build/atv/_dist/atv-example-service/atv-example-service /app/

COPY --from=builder /build/atv/config /app/config

WORKDIR /app

CMD ["./atv-example-service"]
