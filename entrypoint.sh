#!/bin/sh -l

expr="addpath(strcat($2));moxunit_set_path;exit(moxunit_runtests($1));"
if octave --no-gui --eval $expr ; then
  echo "Unit tests failed!"
  exit 1
fi