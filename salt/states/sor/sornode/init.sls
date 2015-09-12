deploy_sor_dirs:
  file.directory:
    - makedirs: True
    - names:
      - /ngs/app/aidet/athena-sor
      - /ngs/app/aidet/installers/athena-sor/support_files
      - /ngs/app/aidet/installers/athena-sor/generated-files
      - /ngs/app/aidet/logs/solr
      - /ngs/app/aidet/logs/solr_edw
      - /ngs/app/aidet/logs/solr_casedb_order_info
      - /ngs/app/aidet/logs/solr_casedb_case_info
	  - /ngs/app/aidet/cassandra/athena-index-commitlog
	  - /ngs/app/aidet/cassandra/athena-index-saved_caches
	  - /ngs1/app/aidet/data/disk/athena-index
	  - /ngs2/app/aidet/data/disk/athena-index
	  - /ngs3/app/aidet/data/disk/athena-index
	  - /ngs4/app/aidet/data/disk/athena-index
	  - /ngs5/app/aidet/data/disk/athena-index
	  - /ngs6/app/aidet/data/disk/athena-index
	  - /ngs7/app/aidet/data/disk/athena-index
	  - /ngs/app/aidet/cassandra/solr/data/athena-index-solr-edwlog
	  - /ngs/app/aidet/cassandra/solr/data/athena-casedb-order-info
	  - /ngs/app/aidet/cassandra/solr/data/athena-casedb-case-info
	  - /ngs/app/aidet/cassandra/solr/data/athena-casedb-audit-detail
	  - /ngs/app/aidet/cassandra/solr/data/athena-index-solr
	  - /ngs/app/aidet/cassandra/solr/config
	  - /ngs/app/aidet/cassandra/solr/data/offline_joblog
	  
	  
/ngs/app/aidet/installers/athena-sor/generated-files/cassandra.yaml:
  file.managed:
    - source: salt://qa/sornode/generated-files/cassandra.yaml