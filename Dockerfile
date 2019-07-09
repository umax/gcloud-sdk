FROM python:2.7-slim

CMD ["/bin/bash"]
ENV GCLOUD_SDK_PATH=/usr/lib/google-cloud-sdk/

RUN apt-get update && apt-get install --no-install-recommends -y \
    apt-transport-https \
    curl \
    gnupg \
    make

RUN pip install --no-cache-dir crcmod

ARG CLOUD_SDK_VERSION=253.0.0
RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk-stretch main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && apt-get install --no-install-recommends -y \
        google-cloud-sdk=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-app-engine-python=${CLOUD_SDK_VERSION}-0 && \
    rm -rf /var/lib/apt/lists/* && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version
