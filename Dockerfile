# Use an official Nginx image as a parent image
FROM nginx:alpine

# Copy your HTML file to the nginx web root directory
COPY index.html /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
