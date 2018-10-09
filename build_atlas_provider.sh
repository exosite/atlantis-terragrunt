#!/bin/bash
set -e
go get github.com/akshaykarle/terraform-provider-mongodbatlas
cd src/github.com/akshaykarle/terraform-provider-mongodbatlas/
git remote add exosite https://github.com/exosite/terraform-provider-mongodbatlas.git
git fetch exosite
git checkout import_cluster
make build
