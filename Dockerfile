FROM node:10-alpine
ENV NODE_ENV "production"
ENV PORT 8079
#ENV NEW_RELIC_LICENSE_KEY=NRAK-7JCF597RJ691YP5MZWST3HWRNY2
ENV NEW_RELIC_LICENSE_KEY=c4bc7ceecc6d65c014b88746bab128121719NRAL
ENV NEW_RELIC_ACCOUNT_ID=3326388
ENV NEW_RELIC_APP_NAME="Sock Shop"
ENV NEW_RELIC_NO_CONFIG_FILE=true
ENV NEW_RELIC_ENABLED=true
ENV NEW_RELIC_RECORD_SQL=raw
ENV NEW_RELIC_SLOW_SQL_ENABLED=true
ENV NEW_RELIC_DISTRIBUTED_TRACING_ENABLED=true
EXPOSE 8079
RUN addgroup mygroup && adduser -D -G mygroup myuser && mkdir -p /usr/src/app && chown -R myuser /usr/src/app

# Prepare app directory
WORKDIR /usr/src/app
COPY package.json /usr/src/app/
COPY yarn.lock /usr/src/app/
RUN chown myuser /usr/src/app/yarn.lock

USER myuser
RUN yarn install

COPY . /usr/src/app

# Start the app
CMD ["/usr/local/bin/npm", "start"]
