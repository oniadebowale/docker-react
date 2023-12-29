# This is production ready
# Specify a(node) base image and name as builder
FROM node:21.2-alpine as builder
# destination working dir to container
WORKDIR /app
#copy package.json to current dir
COPY package.json .
#install some depencencies
RUN npm install
#copy working dir to container
COPY . .
#build project
RUN npm run build
# Specify other(nginx) base image
FROM nginx
#Copy from app/build dir of 'builder' to nginx -- ngnix startsup itself  
COPY --from=builder /app/build /usr/share/nginx/html