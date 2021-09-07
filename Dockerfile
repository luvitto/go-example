# syntax=docker/dockerfile:1
## Build
FROM golang:1.16-buster AS build

WORKDIR /go/src

COPY ./ ./

RUN go build -o /gocontacts

## Deploy
FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /gocontacts /gocontacts
COPY --from=build /go/src/.env /.env

EXPOSE 8000

USER nonroot:nonroot

ENTRYPOINT ["/gocontacts"]
