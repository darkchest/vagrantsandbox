/lib/systemd/system/docker.service:
  file:
    - managed
    - source: salt://docker/docker.service  
    - template: jinja
    - user: root
    - group: root
    - mode: 644

systemctl daemon-reload:
  cmd:
    - run
    - require:
      - file: /lib/systemd/system/docker.service
