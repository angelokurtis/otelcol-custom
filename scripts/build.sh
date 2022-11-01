#!/bin/bash

set -e

export OTEL_VERSION=0.64.1

( set -x ; curl -L -o ocb https://github.com/open-telemetry/opentelemetry-collector/releases/download/v${OTEL_VERSION}/ocb_${OTEL_VERSION}_linux_amd64 )
chmod +x ocb
( set -x ; ./ocb --config builder-config.yaml )
