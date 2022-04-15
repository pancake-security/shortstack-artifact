#!/usr/bin/env bash

srcdir="`dirname "$0"`"
srcdir="`cd "$srcdir"; pwd`"

source $srcdir/../envs.sh

sbin=$SHORTSTACK_ROOT/sbin
export SHORTSTACK_SERVERS=$SHORTSTACK_HOSTS

config=$1
trace=$2
objsz=1000
rep=3
const_servers=4

# Initialize setup
$ARTIFACT_ROOT/scripts/init_exp_mtl3.sh $const_servers $const_servers $const_servers $rep $const_servers $trace $objsz nopushbins none

sleep 4;

# Start daemon that will fail and L2 proxy replica after a certain timeout
/local/deploy/proxy_server manager -h /local/deploy/hosts.csv -f l2_1_0_0 -z 15 &

# Run clients
/local/deploy/shortstack_benchmark -h /local/deploy/hosts.csv -t $trace -n $const_servers -q 512 -o $config-faill2 -m 10000 -w

sleep 2;
