#!/usr/bin/env bash

srcdir="`dirname "$0"`"
srcdir="`cd "$srcdir"; pwd`"

source $srcdir/../envs.sh

sbin=$SHORTSTACK_ROOT/sbin
export SHORTSTACK_SERVERS=$SHORTSTACK_HOSTS

config=$1

echo "X 	Throughput(ops/sec) 	Latency-including-WAN(ms)"
# For estimate of WAN latency we use average latency between AWS us-east-1 and us-west-2 regions measured over 1 week period (73.59ms)
for x in 1 2 3 4; do
	paste <(echo $x) <(cat $srcdir/data/$config-x$x.stats | grep -i "xput" | awk '{print $2}') <(cat $srcdir/data/$config-x$x.stats | grep -i "average latency" | awk '{print (73.59+$3)/100;}')
done
