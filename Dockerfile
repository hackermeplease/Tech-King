FROM node:lts-buster
RUN apt-get update && \
  apt-get install -y \
  RUN npm install && npm install -g qrcode-terminal pm2

COPY . .

  

COPY package.json .



EXPOSE 5000

CMD ["npm", "start"]
