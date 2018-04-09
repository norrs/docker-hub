FROM debian:stretch

ENV CLOUD_SDK_VERSION 196.0.0
RUN apt-get -qqy update && apt-get install -qqy \
        curl \
        gcc \
        python-dev \
        python-setuptools \
        apt-transport-https \
        lsb-release \
        openssh-client \
        git \ 
        gpg \
    && easy_install -U pip && \
    pip install -U crcmod   && \
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && \
    apt-get install -y google-cloud-sdk=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-app-engine-python=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-app-engine-java=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-app-engine-go=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-datalab=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-datastore-emulator=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-pubsub-emulator=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-bigtable-emulator=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-cbt=${CLOUD_SDK_VERSION}-0 \
        kubectl && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version

ARG VERSION=2.3.0-pre10

#VERSION=2.3.0-pre10; curl -LsS "https://github.com/github/hub/releases/download/v$VERSION/hub-linux-amd64-$VERSION.tgz" | tar -C /tmp/foo --strip-components=1 -zxvf -

RUN curl -LsS "https://github.com/github/hub/releases/download/v$VERSION/hub-linux-amd64-$VERSION.tgz" | tar -C /usr --strip-components=1 -zxvf -

# git@github.com:kelseyhightower/hub-credential-helper.git
RUN curl -LsS "https://github.com/kelseyhightower/hub-credential-helper/releases/download/0.0.1/hub-credential-helper-linux-amd64-0.0.1.tgz" | tar -C /usr/bin -zxvf -

RUN git config --global credential.https://github.com.helper /usr/bin/hub-credential-helper

ENTRYPOINT ["/usr/bin/hub"]
