#!/usr/bin/env bash

srcdir="`dirname "$0"`"
srcdir="`cd "$srcdir"; pwd`"

source $srcdir/../envs.sh

sbin=$SHORTSTACK_ROOT/sbin
export JIFFY_SERVERS=$SHORTSTACK_HOSTS

nl1=1
nl2=1
nl3=1
rep=1
nredis=1
trace=$1
objsz=1000
nopushbins="none"
noredis="none"

if [[ "$nopushbins" != "nopushbins" ]]
then
    echo "Pushing binaries"

    $ARTIFACT_ROOT/scripts/push_bins.sh
fi

echo "Generate + sync hosts file"
python3 $SHORTSTACK_ROOT/gen_hosts_file.py /local/deploy/shortstack.hosts /local/deploy/hosts.csv $nl1 1 16 $nl2 1 16 $nl3 16 1 $nredis 1 1 0 $rep $rep
$sbin/sync.sh /local/deploy/hosts.csv

if [[ "$noredis" != "noredis" ]]
then

    echo "Starting redis"
    $sbin/hosts.sh /local/deploy/stop_redis.sh; $sbin/run_redis.sh /local/deploy/hosts.csv

    echo "Init KV store + push distinfo"
    /local/deploy/proxy_server init -h /local/deploy/hosts.csv -o $objsz -t $trace -d /local/deploy/distinfo.bin && $sbin/sync.sh /local/deploy/distinfo.bin

fi

echo "Starting proxies"
$sbin/hosts.sh /local/deploy/stop_proxys.sh; 
sleep 2; 
$sbin/run_l3.sh /local/deploy/hosts.csv -s 1 -c 1 -y 1; 
sleep 4; 
$sbin/run_l2.sh /local/deploy/hosts.csv $rep -c 1 -y 1; 
sleep 4; 
$sbin/run_l1.sh /local/deploy/hosts.csv $rep -c 1;
sleep 4; 
/local/deploy/proxy_server manager -h /local/deploy/hosts.csv -s