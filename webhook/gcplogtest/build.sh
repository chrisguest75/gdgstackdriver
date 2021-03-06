#!/bin/bash

. ../../cloud-env.sh

export NAME=gcplogtest

docker build -t ${NAME} .
docker tag ${NAME}:latest eu.gcr.io/${GCPPROJECT}/webhooks/${NAME}:latest

gcloud ${GCLOUDCONFIGURATION} --project=${GCPPROJECT} docker -- push eu.gcr.io/${GCPPROJECT}/webhooks/${NAME}:latest
