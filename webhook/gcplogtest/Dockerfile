FROM ubuntu

RUN mkdir /workbench

WORKDIR /workbench
COPY run.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/run.sh

# And run it
CMD ["run.sh"]


