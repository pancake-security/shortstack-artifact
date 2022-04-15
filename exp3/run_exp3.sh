#!/usr/bin/env bash

srcdir="`dirname "$0"`"
srcdir="`cd "$srcdir"; pwd`"

source $srcdir/../envs.sh

sbin=$SHORTSTACK_ROOT/sbin
export SHORTSTACK_SERVERS=$SHORTSTACK_HOSTS

config=$1
trace_prefix=$2
objsz=1000
rep=3
const_servers=$3

for x in 20 40 80 99; do

	echo "Starting $config-skew$x";

	trace="$trace_prefix-skew$x"
	if (( $x == 99 )); then
		trace=$trace_prefix
	fi

	echo "Using trace $trace";

	# Initialize setup
	$ARTIFACT_ROOT/scripts/init_exp.sh $const_servers $const_servers $const_servers $rep $const_servers $trace $objsz nopushbins none

	sleep 4;

	# Run clients
	/local/deploy/shortstack_benchmark -h /local/deploy/hosts.csv -t $trace -n $const_servers -q 512 -o $config-skew$x

	sleep 2;


done
