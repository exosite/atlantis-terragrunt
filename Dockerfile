FROM segment/chamber:2 AS chamber

FROM runatlantis/atlantis:v0.16.1
RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.18.6/terragrunt_linux_amd64 && chmod +x terragrunt_linux_amd64 && mv terragrunt_linux_amd64 /usr/bin/terragrunt
COPY --from=chamber /chamber /bin/chamber
RUN chown -R atlantis:atlantis /home/atlantis

COPY requirements.txt ./

ENV BUILD_PACKAGES \
  curl \
  openssh-client \
  sshpass \
  git \
  python3 \
  py-boto \
  py-dateutil \
  py-httplib2 \
  py-paramiko \
  py-pip \
  ca-certificates \
  wget \
  zip \
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
    python2-dev && \
  \
  echo "==> Upgrading apk and system..."  && \
    apk update && apk upgrade && \
  \
  echo "==> Adding Python runtime..."  && \
  apk add --no-cache ${BUILD_PACKAGES} && \
  pip3 install --upgrade pip && \
  \
  echo "==> Installing Python Dependencies..."  && \
  pip install -r requirements.txt --disable-pip-version-check && \
  \
  echo "==> Cleaning up..."  && \
  apk del build-dependencies && \
  rm -rf /var/cache/apk/*

COPY ./ /home/atlantis
