# Use a lightweight Node.js image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies (specifically 'get-port' required by your script)
# If you don't have a package.json, this will create one and install the lib
RUN if [ ! -f package.json ]; then npm init -y && npm install get-port; else npm ci --only=production; fi

# Copy the rest of the application code
COPY . .

# Set a default environment variable for the port
ENV PORT=3000

# Expose the port to the host
EXPOSE 3000

# Start the server
# Replace 'index.js' with your actual filename (e.g., server.js)
CMD ["node", "index.js"]
