# Live Stream with Kubernetes
This repository provides a complete setup for running a live streaming server on Kubernetes using NGINX with RTMP module. With this setup, you can easily stream videos using FFmpeg and serve them over HLS (HTTP Live Streaming). The guide includes Kubernetes deployment files, NGINX configuration, and Docker setup to help you get started quickly. Follow the steps below to deploy your own live-streaming server and start broadcasting in no time! 🚀


# Pre-requisites

Before diving into the steps, ensure that you have the following set up:
- Kubernetes Cluster: A running Kubernetes cluster (you can use a local setup like Minikube or a cloud provider like AWS EKS or Google GKE).
- NGINX with RTMP module: NGINX is required with the RTMP module for handling live stream protocols.
- FFmpeg: This tool is necessary for encoding and pushing your live video to the NGINX RTMP server.
- Docker: For containerizing the NGINX RTMP server and FFmpeg if needed.
- kubectl: Command-line tool to interact with the Kubernetes cluster.
- Ingress Controller (optional): For exposing services outside the Kubernetes cluster if you want external access.
- Git: To clone the repository with the setup files.

# Steps to Set Up Live Streaming with Kubernetes

## 1. Clone the GitHub Repository

Start by cloning the repository that contains all the required code and configuration files.

  ```
  git clone https://github.com/madgicaltechdom/live-stream-kubernetes.git
  cd live-stream-kubernetes
  ```

This repository includes:
- Dockerfile for NGINX RTMP server
- NGINX configuration file (nginx.conf)
- Kubernetes deployment and service YAML files

## 2. Build and Push the Docker Image (Optional)

If you want to customize the NGINX RTMP server, you can rebuild the Docker image. Otherwise, you can skip this step and use the pre-built image available in the repository.

  ```
  docker build -t live-stream-kubernetes/nginx-rtmp:latest .
  docker push live-stream-kubernetes/nginx-rtmp:latest
  ```

## 3. Deploy NGINX RTMP Server on Kubernetes

Apply the Kubernetes deployment and service files from the repository to your cluster:

  ```
  kubectl apply -f k8s/nginx-rtmp-deployment.yaml
  kubectl apply -f k8s/nginx-rtmp-service.yaml
  ```

This will deploy the NGINX RTMP server and expose it using a NodePort service. You can customize the service type (e.g., LoadBalancer) if required.

## 4. Push a Live Stream Using FFmpeg

Once the NGINX RTMP server is running, use FFmpeg to push a live stream to the server.

- Install FFmpeg if you don’t already have it:
  ```
  sudo apt update && sudo apt install ffmpeg
  ```
  
- Push a live stream:
  ```
  ffmpeg -re -i /path/to/video.mp4 -c:v libx264 -preset veryfast -f flv rtmp://<nginx-rtmp-service>:1935/live/stream
  ```
  
- Replace <nginx-rtmp-service> with the external IP or hostname of your NGINX RTMP server.

## 5. Access the Stream

To access the live stream, open the URL in an HLS-compatible media player or browser:

  ```
  http://<nginx-rtmp-service>:8080/hls/stream.m3u8
  ```

Test the stream using VLC Media Player or any HLS-compatible player. I used a Native HLS playback player.

## 6. Verify the Stream

To ensure the RTMP server is working correctly, you can view server statistics:

- Access the RTMP stats page:
  ```
  http://<nginx-rtmp-service>:8080/stat
  ```
  
This page provides details about the live streams currently being broadcast.

## License

This project is licensed under the [MIT License](LICENSE).
