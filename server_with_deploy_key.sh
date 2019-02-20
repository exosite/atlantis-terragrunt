#!/bin/bash
mkdir /home/atlantis/.ssh && echo $GITHUB_MODULE_BASE64_SSH_DEPLOY_KEY | base64 -d > /home/atlantis/.ssh/id_rsa && chmod 600 /home/atlantis/.ssh/id_rsa  && ssh-keyscan -t rsa github.com >> /home/atlantis/.ssh/known_hosts && chown -R atlantis:atlantis /home/atlantis/.ssh
/bin/chamber exec $1 -- atlantis server
