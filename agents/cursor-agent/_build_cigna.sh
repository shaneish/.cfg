#!/usr/bin/env bash

curl https://raw.github.sys.cigna.com/cigna/certfix/master/combined.pem >> combined.crt
podman build --no-cache --dns=8.8.8.8 --build-arg EXTRA_CA_CERT=combined.crt -t cursor-agent-local:latest .
rm combined.pem
