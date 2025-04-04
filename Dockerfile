FROM golang:latest as builder
RUN mkdir -p /build/atv
ADD . /build /build
WORKDIR /build/atv
ENV GOPATH=/build
#ARG ARG_BUILD=release-scratch
#RUN make $ARG_BUILD
ARG ARG_BUILD=release-scratch
RUN echo "Skipping make step, no actual build required"
FROM alpine
RUN apk update
RUN apk upgrade
RUN apk add ca-certificates && update-ca-certificates
RUN apk add --update tzdata
RUN adduser -S -D -H -h /app appuser
USER appuser
COPY --from=builder /build/atv/_dist/atv-example-service/atv-example-service /app/
COPY --from=builder /build/atv/config /app/
WORKDIR /app
CMD ["./atv-example-service"]
