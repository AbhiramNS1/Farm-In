FROM node:20-alpine3.16

WORKDIR /app

COPY package.json .

RUN npm install

COPY dist dist
COPY .env .

EXPOSE 5000

CMD [ "npm","start" ]