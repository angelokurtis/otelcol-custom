FROM golang:1.20.0-alpine3.17 as builder

ENV OTELCOL_BUILDER_VERSION=0.70.0
ENV GO111MODULE=on
ENV CGO_ENABLED 0

RUN apk --update add ca-certificates
WORKDIR /otelcol
COPY builder-config.yaml .
ADD https://github.com/open-telemetry/opentelemetry-collector/releases/download/cmd%2Fbuilder%2Fv${OTELCOL_BUILDER_VERSION}/ocb_${OTELCOL_BUILDER_VERSION}_linux_amd64 ocb
RUN chmod +x ocb && \
    ./ocb --config builder-config.yaml

FROM scratch

ARG USER_UID=10001
USER ${USER_UID}

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /otelcol/dist/otelcol /
COPY otelcol.yaml /etc/otelcol/config.yaml
ENTRYPOINT ["/otelcol"]
CMD ["--config", "/etc/otelcol/config.yaml"]
EXPOSE 8889 4317 4318
