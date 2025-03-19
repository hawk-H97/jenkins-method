# Using nginx to serve static files
FROM nginx:latest

# Setting up the working directory
WORKDIR /usr/share/nginx/html

# Copying all website files from the jenkins workspace to the container
COPY src/ .

# Expose port 80 to access app
EXPOSE 80

# Start your Nginx server
CMD ["nginx", "-g", "daemon off;"]