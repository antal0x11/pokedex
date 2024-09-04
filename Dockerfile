FROM node:22-bookworm-slim AS build

LABEL version="0.0.1-beta"

WORKDIR /app
COPY . /app

RUN npm install
RUN npm run build

FROM nginx AS deploy

RUN mkdir /app
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /app
