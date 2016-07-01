include:
  - stackdriver.install

zookeeper_config:
  file.managed:
    - name: /opt/stackdriver/collectd/etc/collectd.d/zookeeper.conf
    - source: salt://stackdriver/files/zookeeper.conf
    - makedirs: True
    - watch_in:
      - service: stackdriver_services