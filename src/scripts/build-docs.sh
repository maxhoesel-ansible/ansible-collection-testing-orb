#!usr/bin/env bash
#shellcheck disable=all

set -eu
set -o pipefail

mkdir temp-rst

antsibull-docs collection --fail-on-error --breadcrumbs --indexes --use-html-blobs --use-current --dest-dir temp-rst <<parameters.collection-name>>
rsync -cprv --delete-after temp-rst/collections/ rst/collections/
cd rst && sphinx-build -M html ./ ../build -c . --keep-going <<#parameters.sphinx-error-on-warn>> -W <</parameters.sphinx-error-on-warn>>
