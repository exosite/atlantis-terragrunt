FROM golang:1.11 as atlas
COPY ./build_atlas_provider.sh .
RUN bash build_atlas_provider.sh

FROM runatlantis/atlantis:v0.4.10
RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.17.0/terragrunt_linux_amd64 && chmod +x terragrunt_linux_amd64 && mv terragrunt_linux_amd64 /usr/bin/terragrunt
RUN mkdir -p /home/atlantis/terraform.d/plugins/linux_amd64/
COPY --from=atlas /go/bin/terraform-provider-mongodbatlas /home/atlantis/terraform.d/plugins/linux_amd64/
COPY --from=atlas /go/bin/terraform-provider-jsondecode /home/atlantis/terraform.d/plugins/linux_amd64/
