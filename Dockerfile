FROM debian:stretch

ENV GCLOUD_SDK_PATH=/usr/lib/google-cloud-sdk/

# sys packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gcc \
    gnupg \
    python-dev \
    python2.7

# pip + test packages
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python2.7 get-pip.py
RUN pip install --no-cache-dir \
    mock \
    pytest \
    pytest-cov

# Google Cloud SDK
RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk-stretch main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && apt-get install --no-install-recommends -y \
        google-cloud-sdk \
        google-cloud-sdk-datastore-emulator \
        google-cloud-sdk-app-engine-python && \
    rm -rf /var/lib/apt/lists/* && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image
