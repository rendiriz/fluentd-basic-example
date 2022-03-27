FROM fluent/fluentd:v1.14.5-debian-1.0

USER root

RUN buildDeps="sudo make gcc g++ libc-dev" \
  && apt-get update \
  && apt-get install -y --no-install-recommends $buildDeps \
  && sudo gem install fluent-plugin-mongo \
  && sudo gem install fluent-plugin-elasticsearch \
  && sudo gem sources --clear-all \
  && SUDO_FORCE_REMOVE=yes \
  apt-get purge -y --auto-remove \
  -o APT::AutoRemove::RecommendsImportant=false \
  $buildDeps \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

USER fluent

EXPOSE 24224 9880