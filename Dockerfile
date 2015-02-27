FROM python:2.7.9
MAINTAINER James Lal [:lightsofapollo]

ENV HG_URL http://mercurial.selenic.com/release/mercurial-3.3.tar.gz

# Install docutils globally so we can actually build hg
RUN pip install docutils

# Install HG
RUN mkdir -p /tmp/hg && \
    cd /tmp/hg && \
    curl $HG_URL | tar -xz && \
    cd mercurial-* && \
    make install && \
    hg --version
