#!/bin/bash

export GCPPROJECT=webhook-project-35299
export NAME=gcplogtest

. ../../cloud-env.sh

gcloud ${GCLOUDCONFIGURATION} --project=${GCPPROJECT} docker -- pull eu.gcr.io/${GCPPROJECT}/webhooks/${NAME}:latest
docker run --name ${NAME}  eu.gcr.io/${GCPPROJECT}/webhooks/${NAME}:latest
