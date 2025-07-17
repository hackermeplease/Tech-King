FROM debian:bullseye-slim

# Prevent interactive frontend issues
ENV DEBIAN_FRONTEND=noninteractive
FROM debian:buster-slim

RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org/|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.listqqqqqq
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
