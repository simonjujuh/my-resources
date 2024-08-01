#!/bin/bash
set -e

# This script will be executed on the first startup of each new container with the "my-resources" feature enabled.
# Arbitrary code can be added in this file, in order to customize Exegol (dependency installation, configuration file copy, etc).
# It is strongly advised **not** to overwrite the configuration files provided by exegol (e.g. /root/.zshrc, /opt/.exegol_aliases, ...), official updates will not be applied otherwise.

# Exegol also features a set of supported customization a user can make.
# The /opt/supported_setups.md file lists the supported configurations that can be made easily.

# Install vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim || true
vim +PluginInstall +qall

# Install tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
/bin/bash ~/.tmux/plugins/tpm/bin/install_plugins

# Nxc configuration
cp -r /opt/my-resources/setup/nxc/nxc.conf /root/.nxc/nxc.conf

# Clone and pull git repositories
bash /opt/my-resources/setup/git/clone.sh

# Permissions fix
find /workspace/ -type d -exec chmod 770 {} \; -exec chmod g+s {} \;
find /workspace/ -type f -exec chmod 660 {} \;


# The /opt/supported_setups.md file lists the supported configurations that can be made easily.
# LAUNCH_DIRECTORY="$PWD"

# # remove history
# echo -n > ~/.zsh_history

# pentest environment variables source
# FILE=/workspace/.env
# if [ ! -f $FILE ]
# then
#     touch $FILE
# fi
# echo "CLIENT=''" > $FILE
# echo "DOMAIN=''" >> $FILE
# echo "FQDN=''" >> $FILE
# echo "DC=''" >> $FILE
# echo "DC2=''" >> $FILE
# echo "DC3=''" >> $FILE
# echo "USER=''" >> $FILE
# echo "PASSWORD=''" >> $FILE
# echo "USER_ADM=''" >> $FILE
# echo "PASSWORD_ADM=''" >> $FILE

# # build internal pentest tree
# mkdir /workspace/attacks
# mkdir /workspace/attacks/adcs
# mkdir /workspace/attacks/crack
# mkdir /workspace/attacks/cve
# mkdir /workspace/attacks/acl
# mkdir /workspace/attacks/mitm
# mkdir /workspace/attacks/postex
# mkdir /workspace/attacks/relay
# mkdir /workspace/attacks/snowball
# mkdir /workspace/attacks/spray
# mkdir /workspace/attacks/webdav
# mkdir /workspace/enumeration
# mkdir /workspace/enumeration/bloodhound
# mkdir /workspace/enumeration/nmap
# mkdir /workspace/enumeration/pingcastle
# mkdir /workspaces/enumeration/nessus
# mkdir /workspace/loot
# mkdir /workspace/loot/files
# mkdir /workspace/loot/credz
# mkdir /workspace/notes
# touch /workspace/notes/brief.md
# touch /workspace/notes/todo.md
# touch /workspace/notes/comptes.md
# touch /workspace/notes/partages.md
# touch /workspace/notes/questions.md
# touch /workspace/notes/postex.md
# mkdir /workspace/screenshots
# mkdir /workspace/targets
