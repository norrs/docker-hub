FROM debian:stretch

RUN apt-get update && apt-get install -y \
  curl \
  git \
 && rm -rf /var/lib/apt/lists/*

ARG VERSION=2.3.0-pre10

#VERSION=2.3.0-pre10; curl -LsS "https://github.com/github/hub/releases/download/v$VERSION/hub-linux-amd64-$VERSION.tgz" | tar -C /tmp/foo --strip-components=1 -zxvf -

RUN curl -LsS "https://github.com/github/hub/releases/download/v$VERSION/hub-linux-amd64-$VERSION.tgz" | tar -C /usr --strip-components=1 -zxvf -

# git@github.com:kelseyhightower/hub-credential-helper.git
RUN curl -LsS "https://github.com/kelseyhightower/hub-credential-helper/releases/download/0.0.1/hub-credential-helper-linux-amd64-0.0.1.tgz" | tar -C /usr/bin -zxvf -

RUN git config --global credential.https://github.com.helper /usr/bin/hub-credential-helper

ENTRYPOINT ["/usr/bin/hub"]
