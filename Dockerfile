FROM node:lts-buster

RUN apt-get update && \
  apt-get install -y \
  
  imagemagick \
  webp && \
  apt-get upgrade -y && \
  
  
WORKDIR /usr/src/app

COPY package.json .

RUN npm install && npm install -g qrcode-terminal pm2

COPY . .

EXPOSE 5000

CMD ["npm", "start"]
