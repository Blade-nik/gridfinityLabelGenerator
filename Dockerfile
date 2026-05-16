# Build the web application
FROM node:20-alpine AS builder
WORKDIR /app

# Install dependencies and build the web app
COPY web/package.json web/package-lock.json ./
RUN npm ci
COPY web .
RUN npm run build

# Serve the built assets with nginx
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
