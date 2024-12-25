#!/bin/bash

# Expect environment variables to be passed at runtime:
#   - REPO: GitHub org/repo URL
#   - REG_TOKEN: GitHub Actions runner registration token
#   - NAME: Name for this runner

# Configure the runner
./config.sh --url "$REPO" --token "$REG_TOKEN" --name "$NAME" --unattended --replace

# Start the runner
./run.sh
