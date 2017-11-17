#!/bin/bash
while :
do 
	FILESAFEDATETIME=$(date "+%Y-%m-%d-%H-%M-%S")
	curl -L -s -w "${FILESAFEDATETIME} Size:%{size_download} Time:%{time_total} - %{http_code}\n" -o /dev/null https://www.google.com; 
	sleep 5
done
