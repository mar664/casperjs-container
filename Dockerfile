FROM ubuntu:14.04

ENV PHANTOMJS_VERSION 2.1.1

RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y vim git wget libfreetype6 libfontconfig bzip2 python python-dev python-pip python-lxml && \
  pip install tornado fake-useragent requests selenium sheetsync && \
  mkdir -p /srv/var && \
  wget -q --no-check-certificate -O /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  tar -xjf /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 -C /tmp && \
  rm -f /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  mv /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/ /srv/var/phantomjs && \
  ln -s /srv/var/phantomjs/bin/phantomjs /usr/bin/phantomjs && \
  apt-get autoremove -y && \
  apt-get clean all

  ENTRYPOINT ["python", "/selenium/server.py"]
