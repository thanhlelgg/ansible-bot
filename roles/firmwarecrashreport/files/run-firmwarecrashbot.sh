#!/bin/bash
#
# cronjob script to run firmwarecrashbot
#

set -e
set -u

export PYTHONUNBUFFERED=1
export JIRA_USER=
export JIRA_PASS=
export DB_DAYS_INTERVAL=1
export COZMO_TABLE=cozmomessage
export APPLESTORE_API_URL="http://itunes.apple.com/lookup?bundleId=com.anki.cozmo"
export PROD_VERSION='1.5.0'
export MODE_USER=
export MODE_PASS=
export MODE_TIMEOUT=5400


echo "> Cozmo Dev firmwarecrashbot running $(date)"
export MODE_RUN_NOW_URL="https://modeanalytics.com/anki/reports/94fe9480af0a?param_days=DAYS&param_message_table=MESSAGE_TABLE&run=now"
python3 REPO_HOME/robot/tools/firmwarecrashbot.py >> /tmp/upstart-firmwarecrashbot.log 2>&1
echo "> Cozmo Dev firmwarecrashbot killed $(date)"


echo "> Cozmo Prod firmwarecrashbot running $(date)"
export MODE_RUN_NOW_URL="https://modeanalytics.com/anki/reports/ca760e8d3e45?param_days=DAYS&param_message_table=MESSAGE_TABLE&run=now"
python3 REPO_HOME/robot/tools/firmwarecrashbot.py >> /tmp/upstart-firmwarecrashbot.log 2>&1
echo "> Cozmo Prod firmwarecrashbot killed $(date)"
