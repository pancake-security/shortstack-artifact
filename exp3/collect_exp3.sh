#!/usr/bin/env bash

srcdir="`dirname "$0"`"
srcdir="`cd "$srcdir"; pwd`"

source $srcdir/../envs.sh

sbin=$SHORTSTACK_ROOT/sbin
export SHORTSTACK_SERVERS=$SHORTSTACK_HOSTS

config=$1

echo "Skew 	Throughput(ops/sec)"
for x in 20 40 80 99; do
	paste <(echo $x) <(cat $srcdir/data/$config-skew$x.stats | grep -i "xput" | awk '{print $2}')
done