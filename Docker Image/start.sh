#!/bin/bash

REPO=$REPO
REG_TOKEN=$REG_TOKEN
NAME=$NAME


# Create the runner and start the configuration experience
./config.sh --url $REPO_URL --token $REPO_TOKEN --name ${NAME}

./run.sh