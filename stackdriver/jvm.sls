include:
  - stackdriver.install

jvm_config:
  file.managed:
    - name: /opt/stackdriver/collectd/etc/collectd.d/jvm-sun-hotspot.conf
    - source: salt://stackdriver/files/jvm-sun-hotspot.conf
    - makedirs: True
    - defaults:
      JMX_PORT: 2901
    - watch_in:
      - service: stackdriver_services
