export SERVICEACCOUNTNAME=webhook
export GCPPROJECT=webhook-project-35299

. ../cloud-env.sh

gcloud ${GCLOUDCONFIGURATION} --project=${GCPPROJECT} compute firewall-rules delete ${SERVICEACCOUNTNAME}-fw-ssh 
gcloud ${GCLOUDCONFIGURATION} --project=${GCPPROJECT} compute firewall-rules delete ${SERVICEACCOUNTNAME}-network-allow-http 
gcloud ${GCLOUDCONFIGURATION} --project=${GCPPROJECT} compute firewall-rules delete ${SERVICEACCOUNTNAME}-network-allow-https

gcloud ${GCLOUDCONFIGURATION} --project=${GCPPROJECT} compute instances delete "${SERVICEACCOUNTNAME}-vm1" --zone=${zone} 

gcloud ${GCLOUDCONFIGURATION} --project=${GCPPROJECT} iam service-accounts delete ${SERVICEACCOUNTEMAIL} 

