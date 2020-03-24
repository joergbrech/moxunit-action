#!/bin/sh -l

TST_DIRECTORY=$1
SRC_DIRECTORY=$2

RUNTESTS_ARGS="\"$TST_DIRECTORY\", '-verbose'"
TEST_RUNNER=moxunit_runtests

EXPRESSION="addpath(\"/home/MOxUnit/MOxUnit\");"
EXPRESSION="$EXPRESSION addpath(\"$SRC_DIRECTORY\");"
EXPRESSION="$EXPRESSION moxunit_set_path();"
EXPRESSION="$EXPRESSION exit(~$TEST_RUNNER($RUNTESTS_ARGS));"

octave --no-gui --eval "$EXPRESSION"
if [ $? -eq 0 ] ; then
  echo "Unit tests succeeded."
else
  echo "Unit tests failed!"
  exit 1
fi
