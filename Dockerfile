FROM node:lts-buster
WORKDIR /app
COPY . .
RUN npm install --production
EXPOSE 7860
CMD ["npm", "start"]
