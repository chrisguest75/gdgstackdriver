#!/bin/bash 
#Use !/bin/bash -x  for debugging 

export SCRIPT_PATH=${0:A}
export SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
echo Load $SCRIPT_DIR/../utility/logging.sh
source $SCRIPT_DIR/../utility/logging.sh

#****************************************************************************
#** Print out usage
#****************************************************************************

function help() {

  print_header "Help";
  print "${green}Build out a Sample Webhooks Infrastructure using gcloud automation${reset_color}";
  print ""
  print "./build.sh <action> ";
  print "";
  print "Action";
  print "${blue}build${reset_color}                  Build";
  print "";
  print "${yellow}-e|--skiponerror${reset_color}";
  print "${yellow}-h|--help${reset_color}";
  
  print "";
  print "Examples:";
  print "./build.sh build --name=webhook-project-35299";
  print ""

}

#****************************************************************************
#** check_exitcode
#** $1 is the error code $?
#** $2 is skiponerror 
#****************************************************************************

function check_exitcode() {
        if [[ $1 -gt 0 ]];then
            print_error "Exitcode [$1]";
            if [[ $2 = false ]];then
                # skiponerror is false so exit
                exit $1
            fi
            return ${1}
        fi
}

#****************************************************************************
#** Start
#****************************************************************************

ACTION=$1
SKIPONERROR=false
NAME="webhook"

for i in "$@"
do
case $i in
    -n=*|--name=*)
        NAME="${i#*=}"
        shift # past argument=value
    ;;
    -g=*|--gcloudconfig=*)
        GCLOUDCONFIGURATION="--configuration=${i#*=}"
        shift # past argument=value
    ;;     
    -p=*|--gcloudproject=*)
        PROJECTNAME="${i#*=}"
        GCPPROJECT="--project=${i#*=}"
        shift # past argument=value
    ;;    
    -e|--skiponerror)
        SKIPONERROR=true
        shift # past argument=value
    ;;
    -h|--help)
        help
        exit 1
    ;;
esac
done

export region=europe-west1
export zone=europe-west1-c
export webhooks_vpcrange=10.133.0.0/20
#export machinetype="f1-micro"
export machinetype="n1-standard-1"
export IMAGENAME="ubuntu-1604-xenial-v20171107b"


if [ ${ACTION} ]
then
 case ${ACTION} in
   help)
        help
        exit 1
   ;;
   build)
        #*********************************************************
        #* Build
        #*********************************************************
        print_header "Build"

        print_header "${PROJECTNAME} Service Accounts"

        serviceaccountname="${NAME}-sa@${PROJECTNAME}.iam.gserviceaccount.com"
        print "Service Account - ${NAME}-sa ${serviceaccountname}" ${cyan}

        gcloud ${GCLOUDCONFIGURATION} ${GCPPROJECT} iam service-accounts create ${NAME}-sa --display-name ${NAME}-serviceaccount
        check_exitcode $? ${SKIPONERROR}
        gcloud ${GCLOUDCONFIGURATION} ${GCPPROJECT} projects add-iam-policy-binding ${PROJECTNAME} --member="serviceAccount:${serviceaccountname}" --role='roles/logging.logWriter'
        check_exitcode $? ${SKIPONERROR}
        gcloud ${GCLOUDCONFIGURATION} ${GCPPROJECT} projects add-iam-policy-binding ${PROJECTNAME} --member="serviceAccount:${serviceaccountname}" --role='roles/monitoring.metricWriter'
        check_exitcode $? ${SKIPONERROR}
        gcloud ${GCLOUDCONFIGURATION} ${GCPPROJECT} projects add-iam-policy-binding ${PROJECTNAME} --member="serviceAccount:${serviceaccountname}" --role='roles/storage.objectViewer'
        check_exitcode $? ${SKIPONERROR}

        gcloud ${GCLOUDCONFIGURATION} ${GCPPROJECT} compute firewall-rules create ${NAME}-fw-ssh --network "default" --allow tcp:22,icmp
        check_exitcode $? ${SKIPONERROR}

        print_header "${PROJECTNAME} VM"

        print "VM - ${NAME}-vm1" ${cyan}
        gcloud ${GCLOUDCONFIGURATION} ${GCPPROJECT} compute instances create "${NAME}-vm1" --zone=${zone} --machine-type ${machinetype} --subnet "default" --maintenance-policy "MIGRATE" --service-account "${serviceaccountname}" --scopes "https://www.googleapis.com/auth/cloud-platform" --tags "http-server","https-server" --image ${IMAGENAME} --image-project "ubuntu-os-cloud" --boot-disk-size "300" --boot-disk-type "pd-standard" --boot-disk-device-name "${NAME}-vm1"
        check_exitcode $? ${SKIPONERROR}

        # Only on webhooks (allow web 80 and 443)
        if [[ ${NAME} = "webhook" ]]
        then
            print "Firewall - ${NAME}-network-allow-http" ${cyan}
            gcloud ${GCLOUDCONFIGURATION} ${GCPPROJECT} compute firewall-rules create ${NAME}-network-allow-http --network="default" --allow=tcp:8080 --source-ranges=0.0.0.0/0 --target-tags=http-server
            check_exitcode $? ${SKIPONERROR}
            print "Firewall - ${NAME}-network-allow-https" ${cyan}
            gcloud ${GCLOUDCONFIGURATION} ${GCPPROJECT} compute firewall-rules create ${NAME}-network-allow-https --network="default" --allow=tcp:443 --source-ranges=0.0.0.0/0 --target-tags=https-server
            check_exitcode $? ${SKIPONERROR}
        fi
        #*********************************************************
   ;;     
   ssh)
        #*********************************************************
        #* SSH
        #*********************************************************
        print_header "SSH - ${NAME}-vm1"

        gcloud ${GCLOUDCONFIGURATION} ${GCPPROJECT} compute ssh --zone=${zone} "${NAME}-vm1"
        check_exitcode $? ${SKIPONERROR}

        #*********************************************************
   ;;     
   ip)
        #*********************************************************
        #* IP
        #*********************************************************
        print_header "IP - ${NAME}-vm1"

        gcloud ${GCLOUDCONFIGURATION} ${GCPPROJECT} compute instances list
        check_exitcode $? ${SKIPONERROR}

        #*********************************************************
   ;;     
 esac
else
    help
    exit 1
fi


#****************************************************************************
