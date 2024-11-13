tage 1: Build the Angular app
FROM node:18 AS build

# Set the working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the Angular app source code
COPY . .

# Build the Angular app in production mode
RUN npm run build -- --output-path=dist

# Stage 2: Serve the app with Nginx
FROM nginx:alpine

# Copy the build output to Nginx HTML directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]

