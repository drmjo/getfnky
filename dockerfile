FROM golang:alpine

WORKDIR /go/src/getfnky
COPY . .

RUN apk add git

RUN go get -d -v ./...
RUN go install -v ./...

CMD ["getfnky"]