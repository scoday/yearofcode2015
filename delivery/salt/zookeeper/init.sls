{%- from 'zookeeper/settings.sls' import zk with context %}

{{ zk.saltcfg }}grains:
  file.managed:
    - source: salt://zookeeper/rolegrain/grains
    - mode: 755
    - user: aidet
    - group: aidet

{{ zk.conf }}zoo.cfg:
  file.managed:
    - source: salt://zookeeper/zk-config/zoo.jinja
    - mode: 755
    - user: aidet
    - group: aidet
    - template: jinja
    - context:
      port: {{ zk.port }}
      data_dir: {{ zk.data_dir }}
      dataLog_dir: {{ zk.dataLog_dir }}
      zookeepers: {{ zk.zookeepers }}

{{ zk.home }}zookeeper-3.4.5.tar.gz:
  archive:
    - extracted
    - name: {{ zk.home }}
    - source: salt://zookeeper/zk/zookeeper-3.4.5.tar.gz
    - source_hash: md5=b93b0268f284c29d590172b4e3457a97
    - archive_format: tar
    - if_missing: {{ zk.home }}zookeeper-3.4.5.jar

{{ zk.home }}/bin/health_check.sh:
  file.managed:
    - source: salt://zookeeper/zk/health_check.sh
    - mode: 755
    - user: aidet
    - group: aidet
    - template: jinja

{{ zk.data_dir }}:
  file.directory:
    - user: aidet
    - group: aidet
    - makedirs: True

{{ zk.dataLog_dir }}:
  file.directory:
    - user: aidet
    - group: aidet
    - makedirs: True
