FROM ruby:3.1.0
WORKDIR /app
COPY . /app
RUN useradd -ms /bin/bash diplom
RUN apt-get update -y 
ENV NODE_VERSION=16.13.0
RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN chmod 777 -R /app
RUN node --version
RUN npm --version
RUN npm install --global yarn

# ENTRYPOINT ["docker/entrypoint.sh"]
