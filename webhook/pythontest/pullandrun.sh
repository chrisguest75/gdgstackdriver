#!/bin/bash

echo "NOTE: These commands need to be run on the vm we've built on gcp"

export SERVICEACCOUNTNAME=webhook
#export GCPPROJECT=webhook-project-35299
export NAME=pythontest

. ../../cloud-env.sh

gcloud ${GCLOUDCONFIGURATION} --project=${GCPPROJECT} docker -- pull eu.gcr.io/${GCPPROJECT}/webhooks/${NAME}:latest
docker run -p 8080:8080 -d -e=STACKDRIVER_PROJECT=${GCPPROJECT} --name ${NAME} eu.gcr.io/${GCPPROJECT}/webhooks/${NAME}:latest

