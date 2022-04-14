#!/usr/bin/env bash

srcdir="`dirname "$0"`"
srcdir="`cd "$srcdir"; pwd`"

source $srcdir/../envs.sh

sbin=$SHORTSTACK_ROOT/sbin
export JIFFY_SERVERS=$SHORTSTACK_HOSTS

cp -r $SHORTSTACK_ROOT/bin/* /local/deploy/
cp $SHORTSTACK_ROOT/cmakebuild/redis-stable/src/redis-server /local/deploy/
cp $SHORTSTACK_ROOT/cmakebuild/redis-stable/src/redis-cli /local/deploy/
cp $SHORTSTACK_ROOT/cmakebuild/redis-stable/src/redis-benchmark /local/deploy/
cp -r $SHORTSTACK_ROOT/cmakebuild/wondershaper /local/deploy/

cp -r $SHORTSTACK_ROOT/sbin/* /local/deploy/