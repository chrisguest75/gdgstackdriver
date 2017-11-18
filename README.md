# gdgstackdriver
For GDG Workshop on building a chatbot for Hutoma using Python, Docker, GCP and Stackdriver.

#Prerequisites
* GCP Account - https://cloud.google.com
* Google Cloud SDK - https://cloud.google.com/sdk/
* Docker - Docker for 'x' - 
  * https://store.docker.com/editions/community/docker-ce-desktop-windows
  * https://www.docker.com/docker-mac
* An editor such as Visual Studio Code or Atom. 

# Instructions for infrastructure 
* You'll need to have a GCP account - $300 worth of free credits. 
* Create a project and add billing to it.  This won't cost $300. 
* Open a cloud shell in the GCP web console.
* git clone https://github.com/chrisguest75/gdgstackdriver.git
* cd gdgstackdriver
* gcloud config configurations list
* Use the name and project to edit the local cloud-env.sh GCPPROJECT & GCLOUDCONFIGURATION
  * Use vi ./cloud_env.sh (NOTE: i for insert and esc :wq for exit after editing)
* Use cat ./cloud_env.sh to verify 
* Goto gcloud directory inside the repo clone.
* Use the NAME and PROJECT values for project when calling following script 
  *  ./build.sh build -g=cloudshell-739 -p=project-name-here -
  * This will create a VM, a few firewall rules and service account
  * In GCP you can have a look around at the VPC network firewall rules, instances, etc
* Now we will install Docker, Stackdriver and gcplogs override 
  * cat ./provision.sh
  * SSH (make sure you are on new vm)
    * gcloud compute ssh webhook-vm1
    * Now copy and execute the commands inside ./provision.sh one by one
    * This can take a few minutes waiting for the installations 
    * NOTE: It might need prompts to confirm installation


# Instructions for gcplogstest containers
* On your local machine
* gcloud config configurations list
* Use the name and project to edit the local cloud-env.sh GCPPROJECT & GCLOUDCONFIGURATION
  * Use vi ./cloud_env.sh (NOTE: i for insert and esc :wq for exit after editing)
* Use cat ./cloud_env.sh to verify 
* cd ./webhook/gcplogtest
* ./build.sh
* cat ./pullandrun.sh
* cat ./cloud-env.sh
* gcloud --configuration=[config] --project=[projectid] compute ssh webhook-vm1
* Now use the commands to pull and run the docker container on the webhook-vm.

# Instructions Stackdriver
* To see the logs in Stackdriver you will need to create your free basic tier account in the GCP console
* Check the stackdriver logs for the container logs

# Instructions for pythontest
* cd ./webhook/pythontest
* ./build.sh
* cat ./pullandrun.sh
* cat ./cloud-env.sh
* gcloud --configuration=[config] --project=[projectid] compute ssh webhook-vm1
* Now use the commands to pull and run the docker container on the webhook-vm.
* curl http://localhost/health
* You can test the webhook by running ./remoteip.sh and looking for the natIP
* curl http://[natip]/health
* Check the stackdriver logs for the container logs


# Go to hutoma
* Create an account - https://console.hutoma.ai/pages/login.php
* Create a new bot.
* Give it a name 
* Add chit chat skill 
* Type hello into chat window
* Add an intent - call it password
* Add a user expression - I want a password
* Add a user expression - I was a 16 character password
* Add an entity sys.number- give it the name length
* Add a prompt How long would you like it to be?
* Add a response password
* Get the external ip and add the webhook http://[externalip]:80/chat
* Go back to training
* Ask I want a password
* It will ask how long you want it to be
* Enter a number

# Add a dashboard
* Goto stackdriver after generating a few passwords
* Add a logmetric (a query that when matched it adds to a counter)
* Add a dashboard to graph the metric
* (resource.type="gce_instance" jsonPayload.message="password generated") 

TODO:
* Deploy the infra - enable firewall etc
* Install docker 
* Install stackdriver
* Finish off the gcplogstest container
* Push it to container registry
* Run it on VM.
* Check stackdriver 
* Write a basic webhook with tests
* Package it up in a container
* Push it to container registry
* Enable it as a hutoma bot. 
* Now add a dashboard and some basic metrics. 



