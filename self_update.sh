#!/bin/bash
set -e
set -u

ANSIBLE_UPDATE_LOG=/srv/repos/ansible-update.log
SELF_UPDATE_LOG=/srv/repos/self-update.log

post_to_slack() {
  rv=$?
  if [[ ! -v SLACK_TOKEN ]] || [[ ! -v SLACK_CHANNEL ]];then
    echo "Can't find Slack credentials. Skip posting to slack."
    exit $rv
  fi
  message="Bots restarting failed. Check updater logs for more details"
  if [ "$rv" -eq 0 ];then
    message="Automation Results: $(tail -n 2 $SELF_UPDATE_LOG | head -n 1)"
  fi
  curl https://slack.com/api/chat.postMessage -X POST -d \
    "token=$SLACK_TOKEN& channel=$SLACK_CHANNEL& text=$message& username=hockeybot"
  exit $rv
}

trap "post_to_slack" INT TERM EXIT

ANSIBLE_PLAYBOOK=`which ansible-playbook`
if [ -z $ANSIBLE_PLAYBOOK ];then
  echo ansible-playbook not found
  exit 1
fi

DIR="$( dirname "${BASH_SOURCE[0]}" )"
pushd $DIR

#-v option will give us more info for debugging in logfile
$ANSIBLE_PLAYBOOK -v -i "localhost," -c local \
--vault-password-file=ansible_vault_password \
update_ansible.yml > $ANSIBLE_UPDATE_LOG

$ANSIBLE_PLAYBOOK -v -i "localhost," -c local \
--vault-password-file=ansible_vault_password \
site.yml --extra-vars "skip_update=true" > $SELF_UPDATE_LOG
popd
