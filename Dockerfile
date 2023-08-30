
FROM node:18-alpine

ENV NODE_ENV='development'

WORKDIR /opt


COPY ["package*.json", "./"]


RUN npm install 


COPY . .


CMD npm  start
CMD sleep 5000
