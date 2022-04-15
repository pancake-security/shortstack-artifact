 #!/usr/bin/env bash

srcdir="`dirname "$0"`"
srcdir="`cd "$srcdir"; pwd`"

source $srcdir/../envs.sh

sbin=$SHORTSTACK_ROOT/sbin
export SHORTSTACK_SERVERS=$SHORTSTACK_HOSTS

x=$1
trace=$2
objsz=$3


echo "Gen + sync hosts file"
python3 $SHORTSTACK_ROOT/gen_hosts_file.py /local/deploy/shortstack.hosts /local/deploy/hosts.csv $x 16 1 0 1 16 0 16 1 $x 1 1 1 1 0
$sbin/sync.sh /local/deploy/hosts.csv

echo "Starting redis"
$sbin/hosts.sh /local/deploy/stop_redis.sh; $sbin/run_redis.sh /local/deploy/hosts.csv

echo "Init KV store"
/local/deploy/redis_benchmark -i -h /local/deploy/hosts.csv -t $trace -z $objsz

echo "Starting proxies"
$sbin/hosts.sh /local/deploy/stop_proxys.sh; 
sleep 2; 
$sbin/run_enc.sh /local/deploy/hosts.csv -s 24; 
sleep 4; 


