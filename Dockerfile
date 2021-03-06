FROM ubuntu:18.04

MAINTAINER Akarsh "akarsh.thodupunuri0812@gmail.com"

RUN apt-get update -y && \
    apt-get install -y python-pip python-dev 

RUN useradd -m myuser
USER myuser		

COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip install -r requirements.txt

COPY ./cachingservice.py /app/cachingservice.py

ARG REDIS_URL

ARG REDIS_PASSWORD

ARG REDIS_PORT

ARG SERVER_PORT

ENV REDIS_URL=$REDIS_URL \
	REDIS_PASSWORD=$REDIS_PASSWORD \
	REDIS_PORT=$REDIS_PORT \
	SERVER_PORT=$SERVER_PORT

EXPOSE $SERVER_PORT

CMD [ "python", "cachingservice.py" ]