#!/bin/bash
set -e

PROJECT="press-start"
PROJECT_URL="press-start.mrkp.me"

# Ensure the proper AWS environment variables are set
if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo "Missing AWS_ACCESS_KEY_ID!"
  exit 1
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "Missing AWS_SECRET_ACCESS_KEY!"
  exit 1
fi

# Ensure we have s3cmd installed
if ! command -v "s3cmd" >/dev/null 2>&1; then
  echo "Missing s3cmd!"
  exit 1
fi

# Get the parent directory of where this script is and change into our website
# directory
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
DIR="$(cd -P "$( dirname "$SOURCE" )/.." && pwd)"

# Delete any .DS_Store files for our OS X friends.
find "$DIR" -type f -name '.DS_Store' -delete

# Upload the files to S3 - we disable mime-type detection by the python library
# and just guess from the file extension because it's surprisingly more
# accurate, especially for CSS and javascript.
if [ -z "$NO_UPLOAD" ]; then
  echo "Uploading to S3..."

  # Check that the site has been built
  if [ ! -d "$DIR/build" ]; then
    echo "Missing compiled website! Run 'make build' to compile!"
    exit 1
  fi

  s3cmd \
    --quiet \
    --delete-removed \
    --guess-mime-type \
    --no-mime-magic \
    --acl-public \
    --recursive \
    --add-header="Cache-Control: max-age=31536000" \
    --add-header="x-amz-meta-surrogate-key: site-$PROJECT" \
    sync "$DIR/build/" "s3://hc-sites/$PROJECT/latest/"
fi
