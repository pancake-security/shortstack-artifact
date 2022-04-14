#!/usr/bin/env bash

srcdir="`dirname "$0"`"
srcdir="`cd "$srcdir"; pwd`"

source $srcdir/../envs.sh

sbin=$SHORTSTACK_ROOT/sbin
export SHORTSTACK_SERVERS=$SHORTSTACK_HOSTS

config=$1

echo "X 	Throughput(ops/sec)"
for x in 1 2 3 4; do
	paste <(echo $x) <(cat $srcdir/data/$config-x$x.stats | grep -i "xput" | awk '{print $2}')
done