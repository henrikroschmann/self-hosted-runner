#!/bin/bash

REPO=$REPO
REG_TOKEN=$REG_TOKEN
NAME=$NAME

cd /home/docker/actions-runner || exit
./config.sh --url https://github.com/${REPO} --token ${REG_TOKEN} --name ${NAME}

cleanup() {
  echo "Removing runner..."
  ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!

# #!/bin/bash

# # Create the runner and start the configuration experience
# ./config.sh --url $REPO_URL --token $REPO_TOKEN

# ./run.sh