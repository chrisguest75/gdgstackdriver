#!/bin/bash

export SERVICEACCOUNTNAME=webhook
export GCPPROJECT=webhook-project-35299

. ../../cloud-env.sh

gcloud ${GCLOUDCONFIGURATION} --project ${GCPPROJECT} compute instances list --filter="name ~ ^${SERVICEACCOUNTNAME}-*" --format='json' 
