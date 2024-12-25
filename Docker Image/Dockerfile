FROM alpine:3.21.0

ARG RUNNER_VERSION="2.321.0"
ARG RUNNER_VERSION_CHECKSUM="ba46ba7ce3a4d7236b16fbe44419fb453bc08f866b24f04d549ec89f1722a29e"

# Install needed packages
RUN apk update && \
    apk add --no-cache \
        ca-certificates \
        curl \
        sudo \
        unzip \
        iputils \
        bash

WORKDIR /runner

# Download and extract runner
RUN curl -o actions-runner.tar.gz -L \
    "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz" \
    && echo "${RUNNER_VERSION_CHECKSUM}  actions-runner.tar.gz" | sha256sum -c - \
    && tar xzf actions-runner.tar.gz --strip 1 \
    && rm actions-runner.tar.gz

COPY start.sh .
RUN chmod +x start.sh

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# # Debugging step: confirm that start.sh is there
# RUN ls -l /runner

ENTRYPOINT ["./start.sh"]
