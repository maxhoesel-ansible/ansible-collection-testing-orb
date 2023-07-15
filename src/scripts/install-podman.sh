#!/usr/bin/env bash

set -eu
set -o pipefail

retry_with_backoff() {
  local max_attempts=${ATTEMPTS-5}
  local timeout=${TIMEOUT-10}
  local attempt=0
  local exitCode=0

  while [[ $attempt -lt $max_attempts ]]
  do
    "$@"
    exitCode=$?

    if [[ $exitCode == 0 ]]
    then
      break
    fi

    echo "Failure! Retrying in $timeout.." 1>&2
    sleep "$timeout"
    attempt=$(( attempt + 1 ))
    timeout=$(( timeout * 2 ))
  done

  if [[ $exitCode != 0 ]]
  then
    echo "Retry timeout exceeded ($timeout)" 1>&2
  fi

  return $exitCode
}


# Requirements
retry_with_backoff sudo apt-get update -qq
retry_with_backoff apt-get install -qq -y lsb-release

# Install the keyring
sudo mkdir -p /etc/apt/keyrings
retry_with_backoff curl -fsSL "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/unstable/xUbuntu_$(lsb_release -rs)/Release.key" | gpg --dearmor | sudo tee /etc/apt/keyrings/devel_kubic_libcontainers_unstable.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/devel_kubic_libcontainers_unstable.gpg] https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/unstable/xUbuntu_$(lsb_release -rs)/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:unstable.list > /dev/null
retry_with_backoff sudo apt-get update -qq

retry_with_backoff sudo apt-get -qq -y install podman aardvark-dns

# Needed to run rootless containers
sudo sysctl kernel.unprivileged_userns_clone=1
sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 "$(whoami)"
sudo podman system migrate

# Enable the socket
sudo systemctl enable --now podman.socket
