#!/bin/sh -l

expr="addpath(\"$2\");exit(moxunit_runtests(\"$1\"));"

octave --no-gui --eval $expr
if [ $? -eq 0 ] ; then
  echo "Unit tests succeeded."
else
  echo "Unit tests failed!"
  exit 1
fi