ARG BASE=7
FROM ghcr.io/jbakerdev/centos${BASE}
LABEL name="jbakerdev/centos-perl" \
      description="CentOS ${BASE} with Perl"

COPY cpanfile /tmp/

# Update and install packages
RUN yum update -y \
    && yum install -y --setopt=tsflags=nodocs \
        perl-App-cpanminus \
        perl-CPAN \
    && yum clean all

# Install cpm/carton
RUN cpanm -nq App::cpm Carton::Snapshot;

# Install CPAN modules
RUN cpm install -g --show-build-log-on-failure --cpanfile /tmp/cpanfile

# Set default command
CMD ["/usr/bin/bash"]
