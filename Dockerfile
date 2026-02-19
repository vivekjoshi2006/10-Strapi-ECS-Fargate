FROM node:18-alpine
RUN apk add --no-cache build-base gcc autoconf automake libpng-dev vips-dev > /dev/null 2>&1

WORKDIR /opt/app
COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

EXPOSE 1337
CMD ["npm", "run", "develop"]