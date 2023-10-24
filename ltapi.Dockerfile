FROM golang:1.20-alpine3.18 as builder

WORKDIR /bic

COPY go.* ./
RUN go mod tidy

COPY ./ ./

RUN go build -o ./bin/ltapi ./cmd/ltapi

FROM alpine:3.18

WORKDIR /bic

COPY --from=builder /bic/bin/ltapi ./bin/ltapi

CMD ["/bic/bin/ltapi"]

EXPOSE 4000
