FROM node:24

WORKDIR /app

COPY package*.json ./
COPY prisma ./prisma/

RUN npm i

COPY . .

RUN npm run build

EXPOSE 5555

CMD ["npm", "start"]
