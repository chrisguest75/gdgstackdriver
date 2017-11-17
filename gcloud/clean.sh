
. ../cloud-env.sh

gcloud ${GCLOUDCONFIGURATION} ${GCPPROJECT} compute firewall-rules create ${SERVICEACCOUNTNAME}-fw-ssh --network "default"
gcloud ${GCLOUDCONFIGURATION} ${GCPPROJECT} compute firewall-rules create ${SERVICEACCOUNTNAME}-network-allow-http --network="default" 
gcloud ${GCLOUDCONFIGURATION} ${GCPPROJECT} compute firewall-rules create ${SERVICEACCOUNTNAME}-network-allow-https --network="default"

gcloud ${GCLOUDCONFIGURATION} ${GCPPROJECT} compute instances delete "${SERVICEACCOUNTNAME}-vm1" 

gcloud ${GCLOUDCONFIGURATION} ${GCPPROJECT} iam service-accounts create ${SERVICEACCOUNTNAME}-sa 

