#!/bin/bash

export NAME=pythontest

. ../../cloud-env.sh

gcloud ${GCLOUDCONFIGURATION} --project=${GCPPROJECT} docker -- pull eu.gcr.io/${GCPPROJECT}/webhooks/${NAME}:latest
docker run -p 8109:8080 -d -e=STACKDRIVER_PROJECT=${GCPPROJECT} --name ${NAME} eu.gcr.io/${GCPPROJECT}/webhooks/${NAME}:latest

sleep 4

#URL=http://35.195.152.255:80
URL=http://localhost:8109
ROUTE=chat
curl -d '' -X get ${URL}/health
curl -d @./fakerequest.json -H "Content-Type: application/json" -X post ${URL}/${ROUTE}

#docker stop ${NAME}
#docker rm ${NAME}

