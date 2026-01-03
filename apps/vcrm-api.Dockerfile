FROM node:24

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

EXPOSE 3009

CMD ["npm", "start"]
