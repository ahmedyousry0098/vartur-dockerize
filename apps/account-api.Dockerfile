FROM node:24

WORKDIR /app

COPY package*.json .

RUN npm ci

COPY . .

EXPOSE 5555

RUN npm run build

CMD ["npm", "run", "start"]