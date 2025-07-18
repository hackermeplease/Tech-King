FROM node:lts-buster

# Create app directory
WORKDIR /app

# Copy package.json and yarn.lock (or package-lock.json if using npm)
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install --network-concurrency 1

# Copy the rest of your application files
COPY . .

EXPOSE 7860
ENV NODE_ENV=production
CMD ["npm", "start"]
