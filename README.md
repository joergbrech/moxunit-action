# MOxUnit action


[![GitHub Marketplace](https://img.shields.io/badge/Marketplace-v1.2-undefined.svg?logo=github&logoColor=white&style=flat)](https://github.com/marketplace/actions/moxunit-action)
![Test](https://github.com/joergbrech/moxunit-action/workflows/Test/badge.svg) 
[![codecov](https://codecov.io/gh/joergbrech/moxunit-action/branch/master/graph/badge.svg)](https://codecov.io/gh/joergbrech/moxunit-action) 


This action performs unit tests for GNU Octave and Matlab using the unit testing framework [MOxUnit](https://github.com/MOxUnit/MOxUnit). Documentation tests and coverage reports are supported via [MOdox](https://github.com/MOdox/MOdox) and [MOCov](https://github.com/MOcov/MOcov).

## Container

This action uses `qmarlab/octaveci:4.2.2` that contains following packages/versions:

```
Package Name  | Version | Installation directory
--------------+---------+-----------------------
       image  |   2.6.2 | /usr/share/octave/packages/image-2.6.2
          io  |  2.4.10 | /usr/share/octave/packages/io-2.4.10
       optim  |   1.5.2 | /usr/share/octave/packages/optim-1.5.2
    parallel  |   3.1.1 | /usr/share/octave/packages/parallel-3.1.1
  statistics  |   1.3.0 | /usr/share/octave/packages/statistics-1.3.0
      struct  |  1.0.14 | /usr/share/octave/packages/struct-1.0.14
```

## Usage

### CI-beginner github example
 
 1. at your github repo click on the "Actions" button or go to https://github.com/[user]/[repo]/actions
 1. add a new workflow by clicking on "New workflow"
 1. click on  "set up a workflow yourself" to create you .yml configuration file
 1. paste this: (where `mySimpleTest1.m` is a test script of function placed in your repo)
 ```
name: moxunittest

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: joergbrech/moxunit-action@v1
        with:
          tests: mySimpleTest1.m
```
  1. commit the change and go back to actions to check the build status.
  
### CI-non-beginner user

In the simplest case
```
steps:
 - uses: actions/checkout@v2
 - uses: joergbrech/moxunit-action@master
```

runs all MOxUnit test cases found in this repository. A more complex use case could look like this:

```
steps:
- uses: actions/checkout@v2
- uses: joergbrech/moxunit-action@master
  with:
    tests: tests my_extra_testfile.m
    src: src thirdparty util
    with_coverage: true
    doc_tests: true
    cover_xml_file: coverage.xml
- uses: codecov/codecov-action@v1
  with:
    file: ./coverage.xml

```
To use your test data along with Octave packages, you can see [this example configuration file](https://github.com/agahkarakuzu/eda_organized/blob/master/.github/workflows/moxunit.yml).

## Arguments

All file and directory paths are interpreted as relative to the working directory, which defaults to the Github Workspace. Optionally, the working-directory can be changed with the argument `working_directory`, see below.

| Input | Description | Usage |
| - | - | - |
| `tests` | files or directories containing the MOxUnit test cases | *Optional*, defaults to the root directory of the repo. All subdirectories are added recursively. |
| `src` | directories to be added to the Octave search path before running the tests. These directories will be considered in the coverage reports, if coverage is enabled. | *Optional*
| `data` | Directory for test data | *Optional* |
| `pkg` | Octave packages to load. Available options: `image` `io` `optim` `parallel` `statistics` `struct`| *Optional* |
| `ext` | External resources to add to the search put (excluded from coverage)| *Optional* |
| `log_file` | store the output in file output | *Optional* |
| `doc_tests` | set to `true` to run documentation tests with [MOdox](https://github.com/MOdox/MOdox) | *Optional* |
| `with_coverage` | set to `true` to record coverage using [MOCov](https://github.com/MOcov/MOcov) | *Optional* |
| `cover_xml_file` | store coverage XML output in file | *Optional* |
| `cover_html_dir` | store coverage HTML output in directory | *Optional* |
| `cover_junit_xml_file` | store test results in junit XML file | *Optional* |
| `cover_json_file` | store coverage report in json file for  processing by coveralls.io | *Optional* |
| `working_directory` | relative path to a working directory under the github workspace, defaults to `.`. | *Optional* |
