FROM nginx:1.19.9-alpine@sha256:4fe11ac2b8ee14157911dd2029b6e30b7aed3888f4549e733aa51930a4af52af

WORKDIR /build
ENV AWSCLI 1.19.0
ENV KUSTOMIZE=4.0.1
ENV TERRAFORM_VERSION 0.14.7

RUN apk update && \
    apk add --upgrade --no-cache \
    git \
    bash \
    curl \
    wget \
    tar \
    zip \
    unzip \
    docker \
    docker-compose \
    coreutils \
    busybox-extras \
    openssh-client \
    python3 \
    py3-pip \
    && rm -rf /tmp/* /var/cache/apk/*

RUN pip3 install --upgrade pip
RUN pip3 install requests awscli==${AWSCLI}

RUN wget https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE}/kustomize_v${KUSTOMIZE}_linux_amd64.tar.gz && \
    tar -zxvf kustomize_v${KUSTOMIZE}_linux_amd64.tar.gz && \
    chmod +x ./kustomize && \
    mv ./kustomize /usr/local/bin/kustomize && \
    rm -rf /build/*

RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

RUN curl https://stedolan.github.io/jq/download/linux64/jq > /usr/local/bin/jq \
    && chmod +x /usr/local/bin/jq

RUN cd /usr/local/bin && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

CMD ["nginx", "-g", "daemon off;"]
