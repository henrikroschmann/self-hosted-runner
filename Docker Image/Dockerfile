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

# Create a docker group with the same GID as on the host
ARG DOCKER_GID=999  # <-- change to match your host!
RUN groupadd -g $DOCKER_GID docker

# Create a non-root "runner" user, in the "docker" group
# Using a fixed UID e.g., 1001 (any non-zero UID is okay)
RUN useradd -u 1001 -g docker -m runner

# Install GitHub Runner
ARG RUNNER_VERSION="2.321.0"
ARG RUNNER_VERSION_CHECKSUM="ba46ba7ce3a4d7236b16fbe44419fb453bc08f866b24f04d549ec89f1722a29e"

RUN curl -o actions-runner.tar.gz -L \
    "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz" \
 && echo "${RUNNER_VERSION_CHECKSUM}  actions-runner.tar.gz" | sha256sum -c - \
 && tar xzf actions-runner.tar.gz --strip 1 \
 && rm actions-runner.tar.gz

COPY start.sh .
RUN chmod +x start.sh

# Make sure the runner user owns everything in /runner
RUN chown -R runner:docker /runner

# Switch to the non-root user
USER runner

ENTRYPOINT ["./start.sh"]
