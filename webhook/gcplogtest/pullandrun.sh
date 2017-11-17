#!/bin/bash

export GCPPROJECT=webhook-project-35299
export NAME=gcplogtest

gcloud docker -- pull eu.gcr.io/${GCPPROJECT}/webhooks/${NAME}:latest
docker run --name gcplogtest  eu.gcr.io/${GCPPROJECT}/webhooks/${NAME}:latest
