FROM alpine:3.21.0

ARG RUNNER_VERSION="2.321.0"
ARG RUNNER_VERSION_CHECKSUM="ba46ba7ce3a4d7236b16fbe44419fb453bc08f866b24f04d549ec89f1722a29e"

# Update and upgrade the system
RUN apk update && \
    apk add --no-cache \
    ca-certificates \
    curl \
    sudo \
    unzip \
    iputils

# Working directory
WORKDIR /runner


RUN curl -o actions-runner.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && echo "${RUNNER_VERSION_CHECKSUM} actions-runner.tar.gz" | sha256sum -c - \
    && tar xzf ./actions-runner.tar.gz \
    && rm actions-runner.tar.gz


# Copy entrypoint script and make it executable
COPY start.sh .
RUN chmod +x ./start.sh

# Configure the runner
ENTRYPOINT ["./start.sh"]