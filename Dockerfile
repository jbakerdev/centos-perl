FROM ghcr.io/jbakerdev/centos7
LABEL name="jbakerdev/centos-perl" \
      description="CentOS 7 with Perl"

COPY cpanfile /tmp/

# Update and install packages
RUN yum update -y \
    && yum install -y --setopt=tsflags=nodocs \
        perl-App-cpanminus \
    && yum clean all

# Install cpm/carton
RUN cpanm -nq App::cpm App::Yath Carton::Snapshot

RUN cpm install -g --show-build-log-on-failure --cpanfile /tmp/cpanfile

# Set default command
CMD ["/usr/bin/bash"]
