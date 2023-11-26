# Base image with Nginx
FROM nginx:latest

# Install build dependencies and the RTMP module
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential libpcre3 libpcre3-dev libssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /tmp/build && \
    cd /tmp/build && \
    wget https://github.com/arut/nginx-rtmp-module/archive/master.tar.gz && \
    tar -zxvf master.tar.gz

# Download Nginx source code
RUN cd /tmp/build && \
    wget https://nginx.org/download/nginx-$(nginx -v 2>&1 | awk -F '/' '{print $2}').tar.gz && \
    tar -zxvf nginx-*.tar.gz

# Build Nginx with the RTMP module
RUN cd /tmp/build/nginx-* && \
    ./configure --with-http_ssl_module --add-module=/tmp/build/nginx-rtmp-module-master && \
    make && \
    make install

# Cleanup build files
RUN rm -rf /tmp/build

# Expose RTMP and HTTP ports
EXPOSE 1935 80 443
