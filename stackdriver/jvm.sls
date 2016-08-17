{% from "stackdriver/map.jinja" import stackdriver with context %}
include:
  - stackdriver.install

jvm_config:
  file.managed:
    - name: /opt/stackdriver/collectd/etc/collectd.d/jvm-sun-hotspot.conf
    - source: salt://stackdriver/files/jvm-sun-hotspot.conf.jinja
    - template: jinja
    - makedirs: True
    - defaults:
      JMX_PORT: {{stackdriver.JMX_PORT}}
      jvm_conf: {{stackdriver.jvm_conf}}
    - watch_in:
      - service: stackdriver_services
