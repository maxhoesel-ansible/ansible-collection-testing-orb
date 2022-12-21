#!/usr/bin/env bash

set -eu
set -o pipefail

tox -l > /dev/null
tox -l | grep ansible | grep -v "lint" | circleci tests split > /tmp/tests-to-run
while read -r test; do  echo "Running test $test"; tox -e "$test"; done </tmp/tests-to-run
