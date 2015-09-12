{% set sorhome = '/ngs/app/aidet/' %}
{% set sor_install = '/ngs/app/aidet/installers/athena-sor/' %}
{% set sor_support = '/ngs/app/aidet/installers/athena-sor/support-files/' %}
{% set sor_generated = '/ngs/app/aidet/installers/athena-sor/generated-files/' %}

deploy_sor_dirs:
  file.directory:
    - makedirs: True
    - names:
      - {{ sorhome }}build/athena-sor
      - {{ sorhome }}installers/athena-sor/support-files
      - {{ sorhome }}installers/athena-sor/generated-files
      - {{ sorhome }}logs/solr
      - {{ sorhome }}logs/solr_edw
      - {{ sorhome }}logs/solr_casedb_order_info
      - {{ sorhome }}logs/solr_casedb_case_info
      - {{ sorhome }}cassandra/athena-index-commitlog
      - {{ sorhome }}cassandra/athena-index-saved_caches
      - /ngs1/app/aidet/data/disk/athena-index
      - /ngs2/app/aidet/data/disk/athena-index
      - /ngs3/app/aidet/data/disk/athena-index
      - /ngs4/app/aidet/data/disk/athena-index
      - /ngs5/app/aidet/data/disk/athena-index
      - /ngs6/app/aidet/data/disk/athena-index
      - /ngs7/app/aidet/data/disk/athena-index
      - {{ sorhome }}cassandra/solr/data/athena-index-solr-edwlog
      - {{ sorhome }}cassandra/solr/data/athena-casedb-order-info
      - {{ sorhome }}cassandra/solr/data/athena-casedb-case-info
      - {{ sorhome }}cassandra/solr/data/athena-casedb-audit-detail
      - {{ sorhome }}cassandra/solr/data/athena-index-solr
      - {{ sorhome }}cassandra/solr/config
      - {{ sorhome }}cassandra/solr/data/offline_joblog
      - {{ sorhome }}installers/support-files/
 
{{ sor_generated }}cassandra.yaml:
  file.managed:
    - source: salt://sornode/generated-files/cassandra.yaml
    - source: salt://sornode/generated-files/athena-common.properties
    - source: salt://sornode/generated-files/cassandra-rackdc.properties
    - mode: 755
    - user: aidet
    - group: aidet 

{{ sor_support }}apache-cassandra-2.0.9-bin.tar.gz:
  file.managed:
    - source: salt://sornode/support_files/apache-cassandra-2.0.9-bin.tar.gz
    - mode: 755
    - user: aidet
    - group: aidet

#archive.tar:
#  module.run:
#    - options: xzf
#    - tarfile: {{ sorhome }}installers/athena-sor/support_files/apache-cassandra-2.0.9-bin.tar.gz
#    - dest: {{ sorhome }}athena-sor
#    - watch: 
#      - file: {{ sorhome }}installers/athena-sor/support_files/apache-cassandra-2.0.9-bin.tar.gz
#athena-sor:
#  archive.extracted:
#    - name: {{ sorhome }}athena-sor/
#    - source: {{ sorhome }}installers/athena-sor/support_files/apache-cassandra-2.0.9-bin.tar.gz 
#    - archive_format: tar
#    - tar_options: xzf
#    - if_missing: {{ sorhome }}athena-sor/

athena-sor:
  cmd.run:
    - name: tar -xvzf {{ sor_support }}apache-cassandra-2.0.9-bin.tar.gz --strip 1 -C {{ sorhome }}build/athena-sor/
    - name: rm -f {{ sorhome }}build/athena-sor/conf/*
    - name: cp {{ sorhome }}installers/athena-sor/generated-files/* {{ sorhome }}build/athena-sor/conf/
