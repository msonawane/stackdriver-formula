{% from "stackdriver/map.jinja" import stackdriver with context %}
include:
  - stackdriver.repo

# remove collectd since the stackdriver agent bundles it
stackdriver-remove-collectd:
  pkg.purged:
    - pkgs:
      - collectd
      - collectd-core

install packages:
  pkg.installed:
    - names:
      - stackdriver-agent
    - require:
      - pkgrepo: stackdriver-repo

configure_api_key:
  cmd.run:
    - name: /opt/stackdriver/stack-config --api-key {{ stackdriver.api_key }}
    - require:
      - pkg: install packages

stackdriver_services:
  service.running:
    - enable: true
    - names:
      - stackdriver-agent
      - stackdriver-extractor
    