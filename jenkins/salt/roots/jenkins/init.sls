jenkins:
  pkgrepo.managed:
    - humanname: Jenkins
    - name: deb https://pkg.jenkins.io/debian-stable binary/
    - file: /etc/apt/sources.list.d/jenkins.list
    - gpgcheck: 1
    - key_url: https://pkg.jenkins.io/debian/jenkins-ci.org.key
  pkg:
    - installed
    - require:
      - pkgrepo: jenkins
