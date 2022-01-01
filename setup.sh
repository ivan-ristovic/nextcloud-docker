#!/bin/bash

set -xe;

source .env

echo 'Creating nececary directories in $DATA_ROOT'
mkdir -p "${DATA_ROOT}"/{acme-challenge,acme.sh,ssl,postgres,nextcloud}

echo 'Switching default CA to LetsEncrypt'
docker run --rm -v "${DATA_ROOT}/acme.sh:/acme.sh" neilpang/acme.sh \
	acme.sh --set-default-ca --server letsencrypt

echo 'Registering account with CA: $ACME_EMAIL'
docker run --rm -v "${DATA_ROOT}/acme.sh:/acme.sh" neilpang/acme.sh \
	acme.sh --register-account -m "${ACME_EMAIL}"

echo 'Building the service stack...'
docker-compose build

echo 'Done! You may now run `docker-compose up -d` with root privileges to start the service stack'
