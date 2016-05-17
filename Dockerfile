###========================================================================
### File: Dockerfile
###
### Dockerfile that sets up ElasticSearch on CentOS 7.
###
###
### Author: Enrique Fernandez <efcasado@gmail.com>
###========================================================================
FROM       centos:7
MAINTAINER Enrique Fernandez <efcasado@gmail.com>

# Install utilities
RUN yum install -y \
        tar \
        wget

# Install Java 8
RUN cd /opt && \
    wget \
        --no-cookies \
        --no-check-certificate \
        --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
        "http://download.oracle.com/otn-pub/java/jdk/8u40-b25/jre-8u40-linux-x64.tar.gz" && \
    tar xvf jre-8*.tar.gz && \
    rm jre-8*.tar.gz && \
    chown -R root: jre1.8* && \
    alternatives --install /usr/bin/java java /opt/jre1.8*/bin/java 1

# Install ElasticSearch
RUN mkdir -p /opt/elasticsearch && \
    cd /opt/elasticsearch       && \
    curl -L -O https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.3.2/elasticsearch-2.3.2.tar.gz && \
    tar -xvf elasticsearch-2.3.2.tar.gz --strip 1

# Configure
COPY opt/elasticsearch/config /opt/elasticsearch/config

# Entry point
ENTRYPOINT [ "/opt/elasticsearch/bin/elasticsearch" ]
CMD        [ "-Des.insecure.allow.root=true" ]
