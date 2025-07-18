FROM node:lts-buster

# Install Chrome and dependencies for Puppeteer
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    fonts-freefont-ttf \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy package files
COPY package.json .

# Install dependencies
RUN npm install --production

# Bundle app source
COPY . .

# Create directory for session storage
RUN mkdir -p .wwebjs_auth && \
    chown -R node:node .wwebjs_auth

# Switch to non-root user
USER node

# Expose port
EXPOSE 8000

# Start command (using PM2 as in your package.json)
CMD ["pm2-runtime", "start", "index.js", "--name", "malvin-xd"]
