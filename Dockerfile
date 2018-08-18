FROM golang:1.10-stretch as build

ARG PACKAGE=github.com/anthoneous/getfnky
COPY . /go/src/$PACKAGE

RUN go get -v $PACKAGE

FROM debian:stretch-slim

COPY --from=build /go/bin/getfnky /bin/getfnky

ENTRYPOINT ["/bin/getfnky"]
