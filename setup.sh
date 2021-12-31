#!/bin/bash

set -xe;

source .env

echo 'Generating coTURN config...'
cp config/turnserver.conf config/turnserver.conf.v
sed -i "s/\(listening-port=\).\+/\1${COTURN_PORT}/" config/turnserver.conf.v
sed -i "s/\(static-auth-secret=\).\+/\1${COTURN_SECRET}/" config/turnserver.conf.v
sed -i "s/\(realm=\).\+/\1${COTURN_REALM}/" config/turnserver.conf.v
sed -i "s/\(redis-userdb=\"ip=redis password=\).\+/\1${REDIS_PASS}\"/" config/turnserver.conf.v

echo 'Creating nececary directories in $FS_ROOT'
mkdir -p "${FS_ROOT}"/{acme-challenge,acme.sh,ssl,postgres,nextcloud}

echo 'Switching default CA to LetsEncrypt'
docker run --rm -v "${FS_ROOT}/acme.sh:/acme.sh" neilpang/acme.sh \
	acme.sh --set-default-ca --server letsencrypt

echo 'Registering account with CA: $ACME_EMAIL'
docker run --rm -v "${FS_ROOT}/acme.sh:/acme.sh" neilpang/acme.sh \
	acme.sh --register-account -m "${ACME_EMAIL}"

echo 'Done! You may now run `docker-compose up -d` with root privileges to start the service stack'
