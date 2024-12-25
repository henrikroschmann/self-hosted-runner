FROM ubuntu:20.04

ARG DOCKER_GID=110
ARG RUNNER_VERSION="2.321.0"
ARG RUNNER_VERSION_CHECKSUM="ba46ba7ce3a4d7236b16fbe44419fb453bc08f866b24f04d549ec89f1722a29e"

# 1. Install packages
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

# 2. Remove existing 'docker' group (if present), then create a 'docker' group with DOCKER_GID
RUN if getent group docker; then \
      echo "Removing existing 'docker' group"; \
      groupdel docker; \
    fi \
    && groupadd -g $DOCKER_GID docker

# 3. Create non-root 'runner' user with UID 1001 in group 'docker'
RUN useradd -u 1001 -g docker -m runner

# 4. Download/Install GitHub Actions runner
RUN curl -o actions-runner.tar.gz -L \
    "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz" \
 && echo "${RUNNER_VERSION_CHECKSUM}  actions-runner.tar.gz" | sha256sum -c - \
 && tar xzf actions-runner.tar.gz --strip 1 \
 && rm actions-runner.tar.gz

COPY start.sh .
RUN chmod +x start.sh

# 5. Change ownership of /runner to 'runner:docker'
RUN chown -R runner:docker /runner

# 6. Switch to non-root user
USER runner

ENTRYPOINT ["./start.sh"]
