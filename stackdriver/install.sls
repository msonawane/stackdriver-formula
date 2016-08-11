{% from "stackdriver/map.jinja" import stackdriver with context %}
include:
  - stackdriver.repo

# remove collectd since the stackdriver agent bundles it
stackdriver-remove-collectd:
  pkg.purged:
    - pkgs:
      - collectd
      - collectd-core

install_packages:
  pkg.installed:
    - names:
      - stackdriver-agent
    - require:
      - pkgrepo: stackdriver-repo

configure_api_key:
  file.managed:
    - name: {{stackdriver.sysconfig}}
    - source: salt://stackdriver/files/stackdriver-agent
    - template: jinja
    - context:
        API_KEY: {{stackdriver.api_key}}
    - require:
      - pkg: install_packages

stackdriver_services:
  service.running:
    - enable: true
    - names:
      - stackdriver-agent
      - stackdriver-extractor
    - watch:
      - file: configure_api_key
    