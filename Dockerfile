FROM node:lts-buster

# Prevent interactive frontend issues
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y ffmpeg imagemagick libwebp-dev && \
  apt-get upgrade -y && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY package.json .

RUN npm install && npm install -g qrcode-terminal pm2

COPY . .

EXPOSE 5000

CMD ["npm", "start"]
