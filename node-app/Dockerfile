FROM node:12-alpine

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm install

COPY index.js ./

EXPOSE 3000

CMD ["node", "index.js"]