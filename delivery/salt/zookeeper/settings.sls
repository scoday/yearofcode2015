{% set saltcfg		= '/ngs/app/aidet/OpsTools/etc/salt/' %}
{% set home		= '/ngs/app/aidet/build/zk/' %}
{% set conf		= '/ngs/app/aidet/build/zk/conf/' %}
{% set data_dir		= '/ngs/app/aidet/zookeeper/data' %}
{% set dataLog_dir	= '/ngs/app/aidet/zookeeper/datalog' %}
{% set port		= '2290' %}

{%- set zookeepers_hosts = zookeepers_host_dict.values() %}
{%- set zookeeper_host_num = zookeepers_ids | length() %}

{%- if zookeeper_host_num == 0 %}
{{ 'No zookeepers' }}
{%- elif zookeeper_host_num is odd %}
{%- set node_count = zookeeper_host_num %}
{%- elif zookeeper_host_num is even %}
{%- set node_count = zookeeper_host_num - 1 %}
{%- endif %}

{%- set myid = zookeepers_with_ids.get(grains.id, '').split('+')|first() %}

{%- set zk = {} %}
{%- do zk.update( { 'port' : port, 
			   'home' : home,
			   'conf' : conf,
                           'data_dir' : data_dir,
                           'dataLog_dir' : dataLog_dir,
                           'saltcfg' : saltcfg,
			   'myid': myid,
			   'zookeepers': zookeepers,
			   'zookeepers_with_ids': zookeepers_with_ids.values(),
                        }) %}
