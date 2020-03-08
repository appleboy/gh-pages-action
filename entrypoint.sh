#!/bin/sh

set -eu

INPUT_COMMIT_AUTHOR_EMAIL=${INPUT_COMMIT_AUTHOR_EMAIL:-'github-action@users.noreply.github.com'}
INPUT_COMMIT_AUTHOR=${INPUT_COMMIT_AUTHOR:-'GitHub Action'}

sh -c "/bin/drone-gh-pages"
