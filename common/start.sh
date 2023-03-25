#!/bin/bash

set -e

if [ -z "$URL" ]; then
  echo "URL environment variable is not set"
  exit 1
fi

if [ -z "$TOKEN" ]; then
  echo "TOKEN environment variable is not set"
  exit 1
fi

cd /home/docker/actions-runner

./config.sh --unattended --url $URL --token $TOKEN --ephemeral

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token $TOKEN
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
