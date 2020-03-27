#!/bin/sh -l

# Read inputs
TESTS=$1
SRC=$2
LOG_FILE=$3
DOC_TESTS=$4
WITH_COVERAGE=$5
COVER_XML_FILE=$6
COVER_HTML_FILE=$7
COVER_JUNIX_FILE=$8

# Create an Octave expression to set up the environment
SETUP=""

# Add MOxUnit, MOdox and MOcov to the Octave search path
SETUP="$SETUP addpath(\"/home/MOxUnit/MOxUnit\");"
SETUP="$SETUP addpath(\"/home/MOdox/MOdox\");"
SETUP="$SETUP addpath(\"/home/MOcov/MOcov\");"
SETUP="$SETUP moxunit_set_path();"

# add src directories to the path
if ! [ -z $SRC] ; then
  SRC_DIRS=""
  for dir in $SRC
  do 
    SRC_DIRS="$SRC_DIRS'$PWD/$dir',"
  done
  # remove trailing comma
  SRC_DIRS=${SRC_DIRS%?}
fi
SETUP="$SETUP addpath($SRC_DIRS);"

# prepare test case argument
if [ -z $TESTS ] ; then
  TEST_CASES="'.'"
else
  TEST_CASES=""
  for dir in $TESTS
  do
    TEST_CASES="$TEST_CASES'$PWD/$dir',"
  done
  # remove trailing comma
  TEST_CASES=${TEST_CASES%?}
fi
RUNTESTS_ARGS="$TEST_CASES, '-verbose', '-recursive'"

# write to log file
if ! [ -z $LOG_FILE ] ; then
  RUNTESTS_ARGS="$RUNTESTS_ARGS, '-logfile', '$PWD/$LOG_FILE'"
fi

# Run the tests
COMMAND="exit(~moxunit_runtests($RUNTESTS_ARGS));"

# For debugging. Should be deleted in release
echo "Command: $COMMAND"
echo "Setup: $SETUP"

octave --no-gui --eval "$SETUP $COMMAND"
RESULT=$?

# Run documentation tests
if ! [ -z $DOC_TESTS ] && [ "$DOC_TESTS" = "true" ] ; then
  
  if [ -z $SRC_DIRS] ; then
    SRC_DIRS="'.'"
  fi
  COMMAND="exit(~modox_runtests($SRC_DIRS));"
  octave --no-gui --eval "$SETUP $COMMAND"
  RESULT=$(($RESULT + $?))
fi

if [ $RESULT -eq 0 ] ; then
  echo "Unit tests succeeded."
else
  echo "Unit tests failed!"
  exit 1
fi
