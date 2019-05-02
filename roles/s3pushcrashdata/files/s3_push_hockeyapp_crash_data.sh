#!/bin/bash
#
# cronjob script to run s3_push_hockeyapp_crash_data
#

set -e
set -u

export PYTHONUNBUFFERED=1
export S3_BUCKET=anki-qa-hockeyapp-logs
export AWS_REGION=us-west-2
export HOCKEYAPP_TOKEN=
export ACCESS_SECRET_KEY=
export TOP_VERSION=100
export ACCESS_KEY=

echo "> Uploading HockeyApp crash data to S3 - running $(date)"
python3 REPO_HOME/scripts/s3_push_hockeyapp_crash_data.py >> /tmp/upstart-s3-push-crash-data.log 2>&1
echo "> Uploading HockeyApp crash data to S3 - killed $(date)"
