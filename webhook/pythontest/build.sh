#!/bin/bash

. ../../cloud-env.sh

export NAME=pythontest

gcloud ${GCLOUDCONFIGURATION} --project=${GCPPROJECT} iam service-accounts keys create ./key.json --iam-account=${SERVICEACCOUNTEMAIL}

docker build -t ${NAME} .
docker tag ${NAME}:latest eu.gcr.io/${GCPPROJECT}/webhooks/${NAME}:latest

gcloud ${GCLOUDCONFIGURATION} --project=${GCPPROJECT} docker -- push eu.gcr.io/${GCPPROJECT}/webhooks/${NAME}:latest
