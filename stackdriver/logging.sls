google-cloud-logging-repo:
  pkgrepo.managed:
{% if grains.os_family == 'Debian' %}
    - name: deb http://packages.cloud.google.com/apt google-cloud-logging-wheezy main
    - key_url: https://packages.cloud.google.com/apt/doc/apt-key.gpg
{% elif grains.os_family == "RedHat" %}
    - humanname: Google Cloud Logging Agent Repository
    - baseurl: https://packages.cloud.google.com/yum/repos/el$releasever/$basearch/
    - gpgcheck: 1
    - gpgkey: https://packages.cloud.google.com/yum/doc/yum-key.gpg
{% endif %}

google-fluentd-install:
  pkg.installed:
    - names:
      - google-fluentd
      - google-fluentd-catch-all-config
    - require:
      - pkgrepo: google-cloud-logging-repo


google-fluentd_service:
  service.running:
    - enable: true
    - names:
      - google-fluentd
    - require:
      - pkg: google-fluentd-install
