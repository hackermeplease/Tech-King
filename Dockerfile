FROM node:lts-buster

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    ffmpeg \
    imagemagick \
    webp \
    wget \
    gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    fonts-freefont-ttf \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package.json .
RUN npm install --production

# Bundle app source
COPY . .

# Create directory for WhatsApp session storage
RUN mkdir -p .wwebjs_auth && \
    chown -R node:node .wwebjs_auth

# Switch to non-root user
USER node

# Expose port
EXPOSE 7860

# Start command (matches your package.json)
CMD ["npm", "start"]
