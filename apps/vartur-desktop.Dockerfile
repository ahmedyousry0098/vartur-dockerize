FROM node:24

WORKDIR /app

COPY package*.json ./
COPY nx.json ./
COPY tsconfig.base.json ./

RUN npm install

COPY libs/ ./libs/
COPY apps/vartur-desktop/ ./apps/vartur-desktop/
COPY types/ ./types/
COPY eslint/ ./eslint/

ENV NITRO_PORT=3366

EXPOSE ${NITRO_PORT}

CMD ["npx", "nx", "serve", "vartur-desktop"]
