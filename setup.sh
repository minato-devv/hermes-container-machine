#!/bin/bash

container build -t local/ubuntu-machine:latest -f Containerfile
container machine create local/ubuntu-machine:latest --name hermes-agent --host-mount=none
container machine set-default hermes-agent
container machine set -n hermes-agent cpus=2 memory=4G
container machine run -- curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
