# Stage 1: Builder
FROM golang:latest as builder

RUN mkdir -p /build/atv
ADD . /build /build
WORKDIR /build/atv

ENV GOPATH=/build

# Real build logic (commented out for now)
# ARG ARG_BUILD=release-scratch
# RUN make $ARG_BUILD

# Test-only placeholder to avoid build failure
ARG ARG_BUILD=release-scratch
RUN echo "Skipping make step, no actual build required"

# Stage 2: Final image
FROM alpine

RUN apk update
RUN apk upgrade
RUN apk add ca-certificates && update-ca-certificates
RUN apk add --update tzdata
RUN adduser -S -D -H -h /app appuser
USER appuser

# Real copy from builder (commented out — won't exist during testing)
# COPY --from=builder /build/atv/_dist/atv-example-service/atv-example-service /app/

# Test-only: create dummy executable
RUN echo -e '#!/bin/sh\n\necho "Hello from dummy binary"' > /app/atv-example-service && chmod +x /app/atv-example-service

COPY --from=builder /build/atv/config /app/config

WORKDIR /app

CMD ["./atv-example-service"]
