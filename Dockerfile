FROM node:lts-buster

# Create app directory
WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of your application files
COPY . .

EXPOSE 7860
ENV NODE_ENV=production
CMD ["npm", "start"]
