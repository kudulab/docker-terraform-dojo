#!/bin/bash -e

###########################################################################
# This file ensures files are mapped from dojo_identity into dojo_home.
###########################################################################

if [ ! -d "${dojo_identity}/.ssh" ]; then
  echo "${dojo_identity}/.ssh does not exist"
  mkdir -p ${dojo_home}/.ssh
else
  cp -r "${dojo_identity}/.ssh/" "${dojo_home}/"
  find ${dojo_home}/.ssh -name '*id_rsa' -exec chmod -c 0600 {} > /dev/null \;
  find ${dojo_home}/.ssh -name '*id_rsa' -exec chown dojo:dojo {} > /dev/null \;
fi
# we need to ensure that ${dojo_home}/.ssh/config contains at least:
# StrictHostKeyChecking no
echo "StrictHostKeyChecking no
UserKnownHostsFile /dev/null
" > "${dojo_home}/.ssh/config"
chown -R dojo:dojo  ${dojo_home}/.ssh

# not obligatory configuration file
if [ -f "${dojo_identity}/.gitconfig" ]; then
  cp "${dojo_identity}/.gitconfig" "${dojo_home}"
  chown dojo:dojo  ${dojo_home}/.gitconfig
fi

# user might be logged into vault
if [ -f "${dojo_identity}/.vault-token" ]; then
  cp "${dojo_identity}/.vault-token" "${dojo_home}"
  chown dojo:dojo  ${dojo_home}/.vault-token
fi

if [[ -d ${dojo_identity}/.aws ]]; then
    cp -pr ${dojo_identity}/.aws ${dojo_home}/.aws
    chown dojo:dojo -R ${dojo_home}/.aws
fi
