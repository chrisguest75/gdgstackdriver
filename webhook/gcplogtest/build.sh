#!/bin/bash

export GCPPROJECT=webhook-project-35299
export GCLOUDCONFIGURATION=--configuration=guestcode
export NAME=gcplogtest

docker build -t ${NAME} .
docker tag ${NAME}:latest eu.gcr.io/${GCPPROJECT}/webhooks/${NAME}:latest

gcloud ${GCLOUDCONFIGURATION} --project=${GCPPROJECT} docker -- push eu.gcr.io/${GCPPROJECT}/webhooks/${NAME}:latest
