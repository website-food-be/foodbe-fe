# Build stage
FROM node:20 AS build
WORKDIR /react-app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Run stage
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=build /react-app/build /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
