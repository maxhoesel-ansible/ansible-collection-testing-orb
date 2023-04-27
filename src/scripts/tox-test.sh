#!/usr/bin/env bash

set -eu
set -o pipefail

# Retry a given command a number of times.
# Usage: retry <num-of-retries> <delay-between-attempts> command with parameters just like normal
retry() {
  local retries=$1
  local delay=$2
  shift
  shift

  local count=0
  until "$@"; do
    exit=$?
    count=$((count + 1))
    if [ $count -lt "$retries" ]; then
      echo "Retry $count/$retries exited $exit, retrying in $delay seconds..."
      sleep "$delay"
    else
      echo "Retry $count/$retries exited $exit, no more retries left."
      return $exit
    fi
  done
  return 0
}

tox -l > /dev/null
tox -l | grep ansible | grep -v "lint" | circleci tests split > /tmp/tests-to-run
while read -r test; do  echo "Running test $test"; retry "${TEST_RETRIES:-1}" "${TEST_RETRY_DELAY:-300}" tox -e "$test"; done </tmp/tests-to-run
