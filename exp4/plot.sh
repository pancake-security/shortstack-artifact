#!/usr/bin/env bash

srcdir="`dirname "$0"`"
srcdir="`cd "$srcdir"; pwd`"

source $srcdir/../envs.sh

sbin=$SHORTSTACK_ROOT/sbin
export SHORTSTACK_SERVERS=$SHORTSTACK_HOSTS

config=$1

gnuplot -e "inpfile='data/$config.xputgraph'; outfile='data/$config.eps'" plot.gp

echo "Plot generated"