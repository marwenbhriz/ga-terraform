#!/bin/bash

set -o errexit  # always exit on error
set -o errtrace # trap errors in functions as well
set -o pipefail # don't ignore exit codes when piping output
set -o posix    # more strict failures in subshells

IFS="$(printf "\n\t")"

cd "$(mktemp -d /tmp/kubectl-XXX)"

version="1.13.0"
echo -n "Installing kubectl v${version}…"
url="https://storage.googleapis.com/kubernetes-release/release/v${version}/bin/linux/amd64/kubectl"
curl --silent --location --fail --remote-name "${url}"
# Use sudo if needed, empty string if not
sudo_command=$(command -v sudo)
"${sudo_command}" install -m 755 kubectl /usr/local/bin
echo ✓
