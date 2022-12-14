#!/usr/bin/env bash

set -eu
set -o pipefail

# Requirements
sudo apt-get update -qq
sudo apt-get install -qq -y lsb-release

# Install the keyring
sudo mkdir -p /etc/apt/keyrings
curl -fsSL "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/unstable/xUbuntu_$(lsb_release -rs)/Release.key" | gpg --dearmor | sudo tee /etc/apt/keyrings/devel_kubic_libcontainers_unstable.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/devel_kubic_libcontainers_unstable.gpg] https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/unstable/xUbuntu_$(lsb_release -rs)/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:unstable.list > /dev/null
sudo apt-get update -qq

sudo apt-get -qq -y install podman aardvark-dns

# Needed to run rootless containers
sudo sysctl kernel.unprivileged_userns_clone=1
sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 "$(whoami)"
sudo podman system migrate

# Enable the socket
sudo systemctl enable --now podman.socket
