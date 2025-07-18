FROM node:lts-buster
WORKDIR /app
COPY package.json .
RUN npm install --production
COPY . .
EXPOSE 7860
CMD ["npm", "start"]
