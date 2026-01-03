FROM node:24

WORKDIR /app

COPY package*.json ./
COPY nx.json ./
COPY tsconfig.base.json ./

RUN npm install

COPY libs/ ./libs/
COPY apps/ilan-tr-desktop/ ./apps/ilan-tr-desktop/
COPY types/ ./types/
COPY eslint/ ./eslint/

ENV NITRO_PORT=6644

EXPOSE ${NITRO_PORT}

CMD ["npx", "nx", "serve", "ilan-tr-desktop"]
