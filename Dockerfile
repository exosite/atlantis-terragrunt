FROM golang:1.11 as atlas
COPY ./build_atlas_provider.sh .
RUN sh build_atlas_provider.sh

FROM runatlantis/atlantis:v0.4.8
RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.16.10/terragrunt_linux_amd64 && chmod +x terragrunt_linux_amd64 && mv terragrunt_linux_amd64 /usr/bin/terragrunt
COPY --from=atlas /go/bin/terraform-provider-mongodbatlas /usr/local/bin
