FROM ubuntu

RUN apt-get update
RUN apt-get install curl -y
RUN mkdir /workbench

WORKDIR /workbench
COPY run.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/run.sh

# And run it
CMD ["run.sh"]


