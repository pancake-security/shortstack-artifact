#!/usr/bin/env bash

srcdir="`dirname "$0"`"
srcdir="`cd "$srcdir"; pwd`"

source $srcdir/../envs.sh

sbin=$SHORTSTACK_ROOT/sbin
export SERVERLIST=$SHORTSTACK_HOSTS


$srcdir/copy_bins.sh
$sbin/sync.sh /local/deploy/