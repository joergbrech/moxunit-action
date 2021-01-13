#!/bin/sh -l

# Read inputs
TESTS=$1
SRC=$2
LOG_FILE=$3
DOC_TESTS=$4
WITH_COVERAGE=$5
COVER_XML_FILE=$6
COVER_HTML_DIR=$7
COVER_JUNIT_XML_FILE=$8
COVER_JSON_FILE=$9
DATA=$10
PKG=$11
EXT=$12

# Create an Octave expression to set up the environment
SETUP=""

# Add MOxUnit, MOdox and MOcov to the Octave search path
SETUP="$SETUP addpath(\"/home/MOxUnit/MOxUnit\");"
SETUP="$SETUP addpath(\"/home/MOdox/MOdox\");"
SETUP="$SETUP addpath(\"/home/MOcov/MOcov\");"
SETUP="$SETUP setenv(\"PLATFORM\",\"GITHUB_ACTIONS\");"
SETUP="$SETUP moxunit_set_path();"

# add src directories to the path
if ! [ -z $SRC ] ; then
  SRC_DIRS=""
  for dir in $SRC
  do 
    SRC_DIRS="$SRC_DIRS'$PWD/$dir',"
  done
  # remove trailing comma
  SRC_DIRS=${SRC_DIRS%?}
  SETUP="$SETUP addpath($SRC_DIRS);"
else
  # This is used for coverage and documentation tests
  SRC_DIRS="'.'"
fi

# add external directories to the path
if ! [ -z $EXT ] ; then
  for dir in $EXT
  do 
    SETUP="$SETUP addpath(genpath('$PWD/$dir'));"
  done
else
  EXT_DIRS=""
fi

if [ -z $DATA ] ; then
  DATA=""
else
   SETUP="$SETUP addpath(\"$PWD/$DATA\");"
   echo "TEST DATA DIR: $PWD/$DATA"
   ls $PWD/$DATA
fi

# Load Octave packages 
if [ -z $PKG ] ; then
  DATA=""
else
  PKG_LIST=""
  for pkg_name in $PKG
  do 
    PKG_LIST="$PKG_LIST pkg load $pkg_name;"
  done

  SETUP="$SETUP $PKG_LIST pkg list;"
fi

###########################
# Run unit tests #
###########################

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

# with code coverage 
if   [ "$WITH_COVERAGE" = "true" ] \
  || ! [ -z $COVER_XML_FILE ] \
  || ! [ -z $COVER_HTML_DIR ] \
  || ! [ -z $COVER_JUNIT_XML_FILE ] \
  || ! [ -z $COVER_JSON_FILE ] ; then
  RUNTESTS_ARGS="$RUNTESTS_ARGS, '-with_coverage', '-cover', $SRC_DIRS"

  # write to xml file
  if  ! [ -z $COVER_XML_FILE ] ; then
    RUNTESTS_ARGS="$RUNTESTS_ARGS, '-cover_xml_file','$PWD/$COVER_XML_FILE'"
  fi

  # write to html dir
  if  ! [ -z $COVER_HTML_DIR ] ; then
    mkdir -p $COVER_HTML_DIR
    RUNTESTS_ARGS="$RUNTESTS_ARGS, '-cover_html_dir','$PWD/$COVER_HTML_DIR'"
  fi

  # write to junix file
  if  ! [ -z $COVER_JUNIT_XML_FILE ] ; then
    RUNTESTS_ARGS="$RUNTESTS_ARGS, '-junit_xml_file','$PWD/$COVER_JUNIT_XML_FILE'"
  fi

  # write to json file
  if ! [ -z $COVER_JSON_FILE ] ; then
    RUNTESTS_ARGS="$RUNTESTS_ARGS, '-cover_json_file','$PWD/$COVER_JSON_FILE'"
  fi
fi

# Run the tests
COMMAND="exit(~moxunit_runtests($RUNTESTS_ARGS));"

# Print Info
echo "RUNNING UNIT TESTS"
echo "SETUP: $SETUP"
echo "COMMAND: $COMMAND"

octave --no-gui --eval "$SETUP $COMMAND"
RESULT=$?

###########################
# Run documentation tests #
###########################
if [ "$DOC_TESTS" = "true" ] ; then
  COMMAND="exit(~modox_runtests($SRC_DIRS));"
  
  # Print Info
  echo "RUNNING DOCUMENTATION TESTS"
  echo "SETUP: $SETUP"
  echo "COMMAND: $COMMAND"
  
  octave --no-gui --eval "$SETUP $COMMAND"
  RESULT=$(($RESULT + $?))
fi

if [ $RESULT -eq 0 ] ; then
  echo "Unit tests succeeded."
else
  echo "Unit tests failed!"
  exit 1
fi
