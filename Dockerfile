FROM golang:1.14-alpine as builder
RUN apk update && apk add build-base git

RUN mkdir -p /easypki

COPY . /easypki
WORKDIR /easypki/cmd/easypki

RUN go get
RUN go build -o ../../bin/easypki -ldflags "-linkmode external -extldflags -static" -a main.go

FROM scratch

COPY --from=builder /easypki/bin/easypki /bin/easypki
ENTRYPOINT ["/bin/easypki"]
CMD []