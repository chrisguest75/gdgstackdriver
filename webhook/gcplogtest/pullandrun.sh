#!/bin/bash


#export GCPPROJECT=webhook-project-35299
echo "NOTE: These commands need to be run on the vm we've built on gcp"
#export NAME=gcplogtest

. ../../cloud-env.sh

gcloud ${GCLOUDCONFIGURATION} --project=${GCPPROJECT} docker -- pull eu.gcr.io/${GCPPROJECT}/webhooks/${NAME}:latest
docker run --name ${NAME}  eu.gcr.io/${GCPPROJECT}/webhooks/${NAME}:latest
