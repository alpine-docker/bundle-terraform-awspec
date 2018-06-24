FROM ruby:2.4.2

RUN gem install bundler
COPY Gemfile Gemfile
RUN bundle install

# Install terraform
ENV TF_VERSION 0.11.7
RUN apt-get update && \
    apt-get install -y zip && \
    curl -L https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -o terraform.zip && \
    unzip terraform.zip && \
    chmod +x terraform && \
    mv terraform /usr/bin/terraform && \
    apt-get remove -y zip && \
    rm -f terraform.zip

# Install kubectl
RUN apt-get update && \
    apt-get install -y apt-transport-https && \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg |  apt-key add - && \
    touch /etc/apt/sources.list.d/kubernetes.list  && \
    echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" |  tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubectl

# Install heptio authenticator
ENV HEPTIO_VERSION 0.3.0
RUN curl -L https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v${HEPTIO_VERSION}/heptio-authenticator-aws_${HEPTIO_VERSION}_linux_amd64 -o heptio-authenticator-aws && \
    chmod +x heptio-authenticator-aws && \
    mv heptio-authenticator-aws /usr/bin/heptio-authenticator-aws
 
WORKDIR /apps

CMD ["bundle", "--help"]
