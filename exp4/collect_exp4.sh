#!/usr/bin/env bash

srcdir="`dirname "$0"`"
srcdir="`cd "$srcdir"; pwd`"

source $srcdir/../envs.sh

sbin=$SHORTSTACK_ROOT/sbin
export SHORTSTACK_SERVERS=$SHORTSTACK_HOSTS

config=$1

cat $srcdir/data/$config.xput | head -n 1450 | tail -n 200 > $srcdir/data/$config.xputgraph

echo "Wrote graph data to data/$config.xputgraph"
