if [[ $ZSH_EVAL_CONTEXT == 'toplevel' ]]; then
    echo "Script is a subshell it needs to be sourced"
else
    echo "This cloud-env.sh script is being sourced"

    export GCPPROJECT='PROJECT_ID_HERE'
    export GCLOUDCONFIGURATION=--configuration='GCLOUD_CONFIGURATION_NAME'

    export SERVICEACCOUNTNAME=webhook
    export SERVICEACCOUNTEMAIL="${SERVICEACCOUNTNAME}-sa@${GCPPROJECT}.iam.gserviceaccount.com"
    export zone=europe-west1-c
fi
