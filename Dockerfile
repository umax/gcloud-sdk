FROM python:2.7-slim

CMD ["/bin/bash"]
ENV GCLOUD_SDK_PATH=/usr/lib/google-cloud-sdk/

RUN pip install mock pytest pytest-cov

RUN mkdir -p /usr/share/man/man1/
RUN apt-get update && apt-get install --no-install-recommends -y \
    apt-transport-https \
    curl \
    gnupg \
    make \
    openjdk-8-jdk

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
