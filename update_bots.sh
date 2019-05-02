#!/bin/bash
set -e
set -u

ANSIBLE_PLAYBOOK=`which ansible-playbook`
if [ -z $ANSIBLE_PLAYBOOK ];then
  echo ansible-playbook not found
  exit 1
fi

ANSIBLE_GALAXY=`which ansible-galaxy`
if [ -z $ANSIBLE_PLAYBOOK ];then
  echo ansible-playbook not found
  exit 1
fi

DIR="$( dirname "${BASH_SOURCE[0]}" )"
pushd $DIR

if [ ! -f ansible_vault_password ]; then
    echo "Please input the ansible value password (stored in 1-password)"
    read -s PASSWORD
    echo $PASSWORD > ansible_vault_password
    unset PASSWORD
fi

$ANSIBLE_GALAXY install -r requirements.yml
$ANSIBLE_PLAYBOOK -i hosts --vault-password-file=ansible_vault_password site.yml

popd
