FROM alpine:3.21.0

ARG RUNNER_VERSION="2.321.0"
ARG RUNNER_VERSION_CHECKSUM="ba46ba7ce3a4d7236b16fbe44419fb453bc08f866b24f04d549ec89f1722a29e"

# 1. Install .NET dependencies (including icu-libs)
RUN apk update && \
    apk add --no-cache \
        ca-certificates \
        curl \
        unzip \
        iputils \
        bash \
        icu-libs \
        # .NET often also needs krb5-libs, libgcc, libintl, etc. For example:
        krb5-libs \
        libgcc \
        libintl \
        zlib \
    && rm -rf /var/cache/apk/*

WORKDIR /runner

# 2. Download and extract GitHub Actions runner
RUN curl -o actions-runner.tar.gz -L \
    "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz" \
    && echo "${RUNNER_VERSION_CHECKSUM}  actions-runner.tar.gz" | sha256sum -c - \
    && tar xzf actions-runner.tar.gz --strip 1 \
    && rm actions-runner.tar.gz

# 3. Copy your start script as root
COPY start.sh .
RUN chmod +x start.sh

# 4. (Optional) If you have a run-helper.sh or other scripts to copy:
# COPY run-helper.sh .
# RUN chmod +x run-helper.sh

# 5. Create a non-root user, then fix ownership
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN chown -R appuser:appgroup /runner

# 6. Finally, switch to the non-root user
USER appuser

# 7. The entrypoint is your start script
ENTRYPOINT ["./start.sh"]
