FROM ubuntu:xenial
WORKDIR /root
RUN apt-get update \
  && apt-get install -y software-properties-common \
  && add-apt-repository ppa:bitcoin/bitcoin \
  && apt-get update \
  && apt-get install -y \
  git build-essential libtool \
  automake autotools-dev \
  autoconf pkg-config \
  libtool bsdmainutils \
  libboost-all-dev libssl-dev libgmp3-dev \
  libevent-dev \
  libdb4.8-dev libdb4.8++-dev \
  && mkdir .SONO \
  && git clone https://github.com/altcommunitycoin/SONO.git \
  && cd SONO/src \
  && make -f makefile.unix USE_UPNP= \
  && strip SONOd
COPY SONO.conf /root/.SONO/SONO.conf
ENV PATH /root/SONO/src:$PATH
CMD ["SONOd", "-daemon"]
EXPOSE 29855
