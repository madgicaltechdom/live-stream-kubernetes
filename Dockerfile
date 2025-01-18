# Use the pulled image as the base
FROM alfg/nginx-rtmp

RUN apk add --no-cache ffmpeg nginx-mod-rtmp

# Copy your custom nginx.conf into the container
COPY nginx.conf /etc/nginx/nginx.conf

# Expose necessary ports (RTMP and HTTP)
EXPOSE 1935 8080

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
