FROM arm32v7/debian:stretch-slim

ADD promtail-docker-config.yml /etc/promtail/docker-config.yaml

RUN apt-get update && \
  apt-get install tzdata ca-certificates libsystemd-dev unzip wget -qy && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget --output-document /promtail.zip https://github.com/grafana/loki/releases/download/v1.3.0/promtail-linux-arm.zip
RUN unzip /promtail.zip && mv promtail-linux-arm /bin/promtail && rm -rf /promtail.zip

ENTRYPOINT ["/bin/promtail"]
CMD        ["-config.file", "/etc/promtail/promtail.yml"]
