FROM ubuntu:20.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    unzip \
    libicu-dev \
    docker.io \
    apt-utils \
    iputils-ping \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /runner

ARG RUNNER_VERSION="2.321.0"
ARG RUNNER_VERSION_CHECKSUM="ba46ba7ce3a4d7236b16fbe44419fb453bc08f866b24f04d549ec89f1722a29e"

RUN curl -o actions-runner.tar.gz -L \
    "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz" \
    && echo "${RUNNER_VERSION_CHECKSUM}  actions-runner.tar.gz" | sha256sum -c - \
    && tar xzf actions-runner.tar.gz --strip 1 \
    && rm actions-runner.tar.gz

COPY start.sh .
RUN chmod +x start.sh

RUN groupadd -r appgroup && useradd -r -g appgroup appuser
RUN chown -R appuser:appgroup /runner

USER appuser

ENTRYPOINT ["./start.sh"]