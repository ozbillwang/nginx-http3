# Building and Testing HTTP/3 Support with Docker Compose
In this blog post, we’ll explore how to set up a Docker Compose configuration to create two services: an Nginx server with HTTP/3 support and a curl client configured to make HTTP/3 requests. This setup is particularly useful for testing the performance and reliability of HTTP/3 in a local environment.

### Why HTTP/3?
HTTP/3 is the latest evolution of the HTTP protocol, designed to provide better performance, lower latency, and increased security. Unlike HTTP/2, which uses TCP, HTTP/3 operates over QUIC, a transport layer network protocol based on UDP. This allows for more efficient connections, especially in environments with high latency or packet loss.

Reference: https://www.cloudflare.com/learning/performance/what-is-http3/

### Service Descriptions

**web-service**: This service runs an Nginx server configured for HTTP/3. It maps ports 8080 and 8443 for both TCP and UDP, ensuring HTTP/3 compatibility.

**curl**: This service continuously sends HTTP/3 requests to the web-service. It sleeps for five seconds after starting, then sends requests at two-second intervals.

### Network Configuration

**my-network**: A Docker bridge network to enable communication between the services.

### Usage
To support HTTPS with our Nginx server, we need to generate local SSL certificates using mkcert.

```
# Steps to Generate Certificates
# Install mkcert and NSS:
brew install mkcert nss
mkcert -install

# Generate Local Certificates:
mkcert localhost 127.0.0.1 web-service ::1

# Organize the Certificates:
mkdir -p nginx/ssl
cp localhost+3.pem nginx/ssl/nginx.crt
cp localhost+3-key.pem nginx/ssl/nginx.key

# Add Root CA for Testing (never do this for production environment)
cp "$(mkcert -CAROOT)/rootCA.pem" nginx/ssl/rootCA.pem

# Running the Docker Compose Setup
# With everything in place, we can now launch our Docker Compose configuration.

# Start the Services
docker compose up -d

# Monitor the Curl Service
# To verify that our curl service is sending HTTP/3 requests, you can check the logs:
docker logs -f curl-http3

# Clean Up
# When you’re done testing, you can stop and remove the containers with:
docker compose down
```

### Conclusion
Setting up an Nginx server and a curl client within a Docker environment is a convenient way to test HTTP/3. This setup allows developers and network engineers to experiment with the latest web protocols and improve the performance of their applications. We hope this guide has provided a helpful starting point for your own HTTP/3 explorations!
