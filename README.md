# gdgstackdriver
For GDG Workshop on building a chatbot for Hutoma using Python, Docker, GCP and Stackdriver.

#Prerequisites
* Google Cloud SDK
* Docker 


# Instructions for infrastructure 
* You'll need to have a GCP account - $300 worth of free credits. 
* Create a project and add billing to it.  This won't cost $300. 
* Open a cloud shell in the GCP web console.
* git clone https://github.com/chrisguest75/gdgstackdriver.git
* Edit the local cloud-env.sh
* gcloud config configurations list
* Goto gcloud directory inside the repo clone.
* Use the NAME and PROJECT values for project when calling following script 
  *  ./build.sh build -g=cloudshell-739 -p=webhook-project-35299 -e
* cat provision.sh
* gcloud ssh webhook-vm1
* Now copy and execute the commands inside provision.sh
* Docker, Stackdriver and gcplogs override 

# Instructions for gcplogstest containers
* cd ./webhooks/gcplogtest
* ./build.sh
* cat ./pullandrun.sh
* gcloud --configuration=<config> --project=<projectid> compute ssh webhook-vm1
* Now use the commands to pull and run the docker container

# Instructions Stackdriver
* To see the logs in Stackdriver you will need to create your free basic tier account in the GCP console
* Check the stackdriver logs for the container logs

# Instructions for pythontest
* cd ./webhooks/pythontest
* ./build.sh
* cat ./pullandrun.sh
* gcloud --configuration=<config> --project=<projectid> compute ssh webhook-vm1
* Now use the commands to pull and run the docker container

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
* Get the external ip and add the webhook http://<externalip>:80/chat
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



