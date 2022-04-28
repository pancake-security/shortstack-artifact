#!/usr/bin/env bash

srcdir="`dirname "$0"`"
srcdir="`cd "$srcdir"; pwd`"

source $srcdir/../envs.sh

sbin=$SHORTSTACK_ROOT/sbin
export SHORTSTACK_SERVERS=$SHORTSTACK_HOSTS

nl1=1
nl2=0
nl3=0
rep=1
nredis=$1
trace=$2
objsz=$3
nopushbins=$4
noredis=$5

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
$sbin/run_pancake.sh /local/deploy/hosts.csv -s 24 -c 1;

echo "Done"
