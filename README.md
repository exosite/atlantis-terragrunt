# Atlantis-Terragrunt

Docker image that enables using Atlantis with Terragrunt

# Description

This docker image runs Atlantis with Terragrunt support.

Atlantis https://www.runatlantis.io/docs/ is a tool that aims to create build system for terraform codes.

Terragrunt https://terragrunt.gruntwork.io is a tool that try to reduce common pitfalls on Terrafrom.

# Building

This repo is configured to build automatically on Dockerhub upon pushing tagged release or to master branch. 
See Dockerhub project for more details https://hub.docker.com/r/exositebot/atlantis-terragrunt .

# Deploying

This image is deployed using Atlantis it self, see
- Staging : https://github.com/exosite/ops_terraform/blob/master/staging/us-west-2/atlantis/main.tf
- Production : https://github.com/exosite/ops_terraform/blob/master/prod/us-west-2/atlantis/main.tf 
