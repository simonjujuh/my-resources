#!/bin/bash

### Variables
LOG_FILE="/tmp/install_resources.$(date +%F_T).log"
TOOLS_DIR=/opt/my-resources/tools
LISTS_DIR=/opt/my-resources/lists
ALIASES_FILE=/opt/my-resources/setup/zsh/aliases
HISTORY_FILE=/opt/my-resources/setup/zsh/history

[[ -d "${TOOLS_DIR}" ]] || mkdir -p "${TOOLS_DIR}"
[[ -d "${LISTS_DIR}" ]] || mkdir -p "${LIST_DIR}"

### Functions

add-alias() {
    grep -qxF "$@" "${ALIASES_FILE}" || echo "$@" >> "${ALIASES_FILE}" 
}

add-history() {
    grep -qxF "$@" "${HISTORY_FILE}" || echo "$@" >> "${HISTORY_FILE}" 
}

### Install Tools

# exec > "${LOG_FILE}" 2>&1

# # Install udp_proto_scanner
# git clone https://github.com/CiscoCXSecurity/udp-proto-scanner $TOOLS_DIR/udp-proto-scanner || true
# add-alias "alias udp-proto-scanner.pl='${TOOLS_DIR}/udp-proto-scanner/udp-proto-scanner.pl'"
# add-history 'udp-proto-scanner.pl -f $IP_FILE'

# # Update nxc configuration
# sed -i "s/log_mode = False/log_mode = True/" ~/.nxc/nxc.conf
# sed -i "s/reveal_chars_of_pwd = 0/reveal_chars_of_pwd = 2/" ~/.nxc/nxc.conf

# # Metasploit installation
# service postgresql start
# msfdb init

# # Install medusa
# apt install --yes medusa

# # Install Pty4all (easy reverse shell)
# git clone https://github.com/laluka/pty4all $TOOLS_DIR/pty4all || true
# add-alias "alias pty4all='cd ${TOOLS_DIR}/pty4all/ && ./socat-multi-handler.sh'"

### Install wordlists

install_git_wordlists() {
    git_wordlists_urls=(
        "https://github.com/swisskyrepo/PayloadsAllTheThings"
        "https://github.com/danielmiessler/SecLists"
        "https://github.com/1N3/BruteX"
        "https://github.com/1N3/IntruderPayloads"
        "https://github.com/tarraschk/richelieu"
        # "https://github.com/simonjujuh/wordlists/"
        # "https://github.com/projectdiscovery/fuzzing-templates"
        # "https://github.com/berzerk0/Probable-Wordlists"
        # "https://github.com/cujanovic/Open-Redirect-Payloads"
        # "https://github.com/ignis-sec/Pwdb-Public"
        # "https://github.com/Karanxa/Bug-Bounty-Wordlists"
    )

    for url in "${git_wordlists_urls[@]}"; do
        dest="${LISTS_DIR}/$(echo "$url" | awk -F '/' '{ print $NF }' | tr '[A-Z]' '[a-z]')"
        [ -d "${dest}" ] || git clone "$url" "$dest"
    done

} 

### Call install functions

install_git_wordlists