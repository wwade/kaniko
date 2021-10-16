FROM golang:1.16-bullseye

# Install deps for gsutil and docker
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gcc \
    gnupg \
    iproute2 \
    iputils-ping \
    libffi-dev \
    lsb-release \
    python3-dev \
    python3-pip \
    python3-setuptools

# Set up docker repo
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Install docker
RUN apt-get update && apt-get install -y  docker-ce docker-ce-cli containerd.io

# Install container-diff and gsutil
RUN curl -LO https://storage.googleapis.com/container-diff/latest/container-diff-linux-amd64 && \
    install container-diff-linux-amd64 /usr/local/bin/container-diff
RUN pip install gsutil
