#!/bin/bash

# Configure the runner
./config.sh --url "$REPO" --token "$REG_TOKEN" --name "$NAME" --unattended --replace

# Start the runner
./run.sh