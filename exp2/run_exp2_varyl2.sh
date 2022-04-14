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

for x in 1 2 3 4; do

	echo "Starting $config-x$x";

	# Initialize redis only during first run
	redisflag="none";
	if (( $x > 1 )); then
		redisflag="noredis";
	fi

	# Initialize setup
	$ARTIFACT_ROOT/scripts/init_exp.sh $const_servers $x $const_servers $rep $const_servers $trace $objsz nopushbins $redisflag

	sleep 4;

	# Run clients
	/local/deploy/shortstack_benchmark -h /local/deploy/hosts.csv -t $trace -n $const_servers -q 512 -o $config-varyl2-x$x

	sleep 2;


done