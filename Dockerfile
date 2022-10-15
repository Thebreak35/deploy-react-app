FROM node:18.11.0-buster-slim as builder

WORKDIR /app

COPY . .

RUN npm ci

RUN npm run build


FROM nginx:1.23.1-alpine as production

ENV NODE_ENV production

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]