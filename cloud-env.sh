if [[ $ZSH_EVAL_CONTEXT == 'toplevel' ]]; then
    echo "Script is a subshell it needs to be sourced"
else
    echo "This cloud-env.sh script is being sourced"

    export GCPPROJECT=webhook-project-35299
    export GCLOUDCONFIGURATION=--configuration=guestcode
    export SERVICEACCOUNTNAME=webhook
    export SERVICEACCOUNTEMAIL="${SERVICEACCOUNTNAME}-sa@${GCPPROJECT}.iam.gserviceaccount.com"
fi
