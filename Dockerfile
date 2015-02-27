FROM python:2.7.9
MAINTAINER James Lal [:lightsofapollo]

ENV HG_URL http://mercurial.selenic.com/release/mercurial-3.3.tar.gz
ENV VCS_REPO https://hg.mozilla.org/hgcustom/version-control-tools/

# The pushlog extension uses this env and will fail if it is not set.
ENV USER user@example.com

# Install docutils globally so we can actually build hg
RUN pip install docutils

# Install HG
RUN mkdir -p /tmp/hg && \
    cd /tmp/hg && \
    curl $HG_URL | tar -xz && \
    cd mercurial-* && \
    make install && \
    hg --version

# Install version control tools
RUN hg clone $VCS_REPO /version-control-tools

# Initialize our dummy repo...
RUN mkdir -p /repo && \
    cd /repo && \
    hg init . && \
    echo "Hello" > README && \
    hg add README && \
    hg commit -m 'Init' README

COPY hgrc /repo/.hg/hgrc

WORKDIR /repo

EXPOSE 8000
CMD ["hg", "serve"]
