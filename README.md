Make sure you are VPN'd into the Anki network or in Anki SF before you begin. 

Steps:

1. Install Homebrew: '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
2. Tap a cask to gain access to some more advanced features: 'brew tap caskroom/cask'
3. Install Vagrant with homebrew: 'brew cask install vagrant'
   version 1.9.1
4. Install Ansible with pip2: 'pip2 install ansible' 
   version 2.3.0.0
5. Run 'vagrant plugin install vagrant-vsphere' to install the plugin
   version 1.11
6. Update your Vagrantfile to include your username
7. Install rvm_io with `ansible-galaxy install requirements.yml`
8. Run 'vagrant up'

This playbook combines giving correct SSH access and deploying out various bots.  It will provision a machine and check that it's up to date and then download the repos and deploy the bot.
If there is an issue with starting up the bots it will automatically revert what was deployed.

In order to view the vars/protected.yml file or ssh key which have sensative information you have to run:
`ansible-vault decrypt <filename>` and give the password which is located in the build 1password keychain
To re-encrypt run `ansible-vault encrypt <filename>`

In order to run the script simply run: `./update_bots.sh` from the root repo.  You will be prompted for a value password from the build 1password keychain
This password will be stored in plain text as a file in the repo so don't check it in
You can also use the `update_bots` command from slack if you have access.
