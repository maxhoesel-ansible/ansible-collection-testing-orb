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
# shellcheck disable=2086
retry_with_backoff sudo apt-get install -qq -y $EXTRA_PACKAGES
