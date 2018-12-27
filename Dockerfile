FROM golang:1.11 as atlas
COPY ./build_atlas_provider.sh .
RUN bash build_atlas_provider.sh

FROM runatlantis/atlantis:v0.4.13
RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.17.3/terragrunt_linux_amd64 && chmod +x terragrunt_linux_amd64 && mv terragrunt_linux_amd64 /usr/bin/terragrunt
COPY --from=atlas /go/bin/terraform-provider-mongodbatlas /home/atlantis/.terraform.d/plugins/
COPY --from=atlas /go/bin/terraform-provider-jsondecode /home/atlantis/.terraform.d/plugins/
RUN chown -R atlantis:atlantis /home/atlantis

COPY requirements.txt ./

ENV BUILD_PACKAGES \
  curl \
  openssh-client \
  sshpass \
  git \
  python \
  py-boto \
  py-dateutil \
  py-httplib2 \
  py-paramiko \
  py-pip \
  ca-certificates \
  wget \
  unzip \
  make \
  jq

RUN set -x && \
  \
  echo "==> Adding build-dependencies..."  && \
  apk --update add --virtual build-dependencies \
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev \
    python-dev && \
  \
  echo "==> Upgrading apk and system..."  && \
    apk update && apk upgrade && \
  \
  echo "==> Adding Python runtime..."  && \
  apk add --no-cache ${BUILD_PACKAGES} && \
  pip install --upgrade pip && \
  \
  echo "==> Installing Python Dependencies..."  && \
  pip install -r requirements.txt --disable-pip-version-check && \
  \
  echo "==> Cleaning up..."  && \
  apk del build-dependencies && \
  rm -rf /var/cache/apk/*
