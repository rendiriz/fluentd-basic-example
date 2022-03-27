#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Cleanup files
rm -f *.crt *.csr *_creds *.jks *.srl *.key *.pem *.der *.p12 *.log

# Generate CA key
CA="snakeoil-wj-1"
SSL_PASSWORD="elastic-password"

openssl req -new -x509 -keyout ${CA}.key -out ${CA}.crt -days 3650 -subj '/CN=wj1.test.kitabikin.com/OU=KBTEST/O=KITABIKIN/L=BANDUNG/ST=WJ/C=ID' -passin pass:${SSL_PASSWORD} -passout pass:${SSL_PASSWORD}

users=(elastic es01 es02 kibana fluentd)
echo "Creating certificates"
printf '%s\0' "${users[@]}" | xargs -0 -I{} -n1 -P15 sh -c './certs-create-per-user.sh "$1" > "certs-create-$1.log" 2>&1 && echo "Created certificates for $1"' -- {}
echo "Creating certificates completed"
