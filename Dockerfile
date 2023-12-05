# Stage 1: Build the application
FROM nikolaik/python-nodejs:python3.8-nodejs14

ENV NODE_WORKDIR /app
WORKDIR $NODE_WORKDIR

ADD . $NODE_WORKDIR

# Import the GPG key for the Yarn repository
RUN wget -qO - https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/yarn-archive-keyring.gpg \
    && echo 'deb [signed-by=/usr/share/keyrings/yarn-archive-keyring.gpg] https://dl.yarnpkg.com/debian stable main' > /etc/apt/sources.list.d/yarn.list

# Update package list and install necessary packages
RUN apt-get update && \
    apt-get install -y build-essential gcc wget git libvips

# Install Node.js and Yarn
RUN apt-get install -y yarn

# Install Node.js dependencies
RUN npm install canvas@2.6.1 && npm install # TODO: canvas crashes if installed via npm install from package.json

# Stage 2: Production image
EXPOSE 4888

# Continue with the rest of your Dockerfile as needed
CMD ["node", "index.js"]
