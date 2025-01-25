# Use the pulled image as the base
FROM alfg/nginx-rtmp

# Install necessary packages
RUN apk add --no-cache ffmpeg nginx-mod-rtmp

# Create the HLS directory and set permissions
RUN mkdir -p /usr/share/nginx/html/hls && \
    chmod -R 755 /usr/share/nginx/html/hls/

# Copy your custom nginx.conf into the container
COPY nginx.conf /etc/nginx/nginx.conf

# Expose necessary ports (RTMP and HTTP)
EXPOSE 1935 8080

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
