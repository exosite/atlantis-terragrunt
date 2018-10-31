#!/bin/bash
set -e

go get github.com/akshaykarle/terraform-provider-mongodbatlas
pushd "$GOPATH/src/github.com/akshaykarle/terraform-provider-mongodbatlas/"
git remote add exosite https://github.com/exosite/terraform-provider-mongodbatlas.git
git fetch exosite
git checkout import_cluster
CGO_ENABLED=0 make build
popd

go get github.com/EvilSuperstars/terraform-provider-jsondecode
pushd "$GOPATH/src/github.com/EvilSuperstars/terraform-provider-jsondecode"
CGO_ENABLED=0 make build
popd
