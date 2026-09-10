# Build Stage - Node 22 resolves Vite crypto.hash errors
FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Production Stage - Nginx
FROM nginx:alpine

# Assumes Vite builds to 'dist'
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
