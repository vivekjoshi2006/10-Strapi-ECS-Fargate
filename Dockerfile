FROM node:18-alpine
WORKDIR /opt/app
COPY package.json ./
COPY package-lock.json ./

RUN npm install

COPY . .

RUN npm run build
EXPOSE 1337
CMD ["npm", "run", "develop"]