FROM golang:1.20-alpine3.18 as builder

WORKDIR /bic

COPY go.* ./
RUN go mod tidy

COPY ./ ./
RUN go build -o ./bin/ltcoordinator ./cmd/ltcoordinator
RUN go build -o ./bin/ltapi ./cmd/ltapi


FROM alpine:3.18

WORKDIR /bic

COPY --from=builder /bic/bin/ltapi ./bin/ltapi
COPY --from=builder /bic/bin/ltcoordinator ./bin/ltcoordinator

COPY build/docker/entrypoint_single_image.sh ./bin/entrypoint_single_image.sh

CMD ["/bic/bin/entrypoint_single_image.sh"]

EXPOSE 4000
