FROM node:lts-buster

# Install system dependencies (fully corrected)
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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install app dependencies
COPY package.json .
RUN npm install --production

# Copy app source
COPY . .

# Create WhatsApp session directory
RUN mkdir -p .wwebjs_auth

# Expose port
EXPOSE 7860

# Start command
CMD ["npm", "start"]
