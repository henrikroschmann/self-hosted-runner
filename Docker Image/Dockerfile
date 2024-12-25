FROM ubuntu:20.04

# Install base tools needed by the runner
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    sudo \
    unzip \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /runner

# Download the GitHub Actions Runner (example version)
ARG RUNNER_VERSION="2.321.0"
ARG RUNNER_VERSION_CHECKSUM="ba46ba7ce3a4d7236b16fbe44419fb453bc08f866b24f04d549ec89f1722a29e"

RUN curl -o actions-runner.tar.gz -L \
    "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz" \
    && echo "${RUNNER_VERSION_CHECKSUM}  actions-runner.tar.gz" | sha256sum -c - \
    && tar xzf actions-runner.tar.gz --strip 1 \
    && rm actions-runner.tar.gz

# Copy scripts
COPY start.sh .
RUN chmod +x start.sh

# Optionally create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN chown -R appuser:appgroup /runner
USER appuser

ENTRYPOINT ["./start.sh"]
