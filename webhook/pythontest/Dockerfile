FROM python:3

RUN mkdir /workbench
ADD requirements.txt /workbench
RUN pip install -r /workbench/requirements.txt

ADD main.py /workbench
ADD key.json /workbench

WORKDIR /workbench

ENV GOOGLE_APPLICATION_CREDENTIALS key.json
ENV STACKDRIVER_PROJECT "project"

CMD [ "python", "./main.py" ]

