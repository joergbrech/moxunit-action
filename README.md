# MOxUnit action


[![GitHub Marketplace](https://img.shields.io/badge/Marketplace-v1.1-undefined.svg?logo=github&logoColor=white&style=flat)](https://github.com/marketplace/actions/moxunit-action)
![Test](https://github.com/joergbrech/moxunit-action/workflows/Test/badge.svg) 
[![codecov](https://codecov.io/gh/joergbrech/moxunit-action/branch/master/graph/badge.svg)](https://codecov.io/gh/joergbrech/moxunit-action) 


This action performs unit tests for GNU Octave and Matlab using the unit testing framework [MOxUnit](https://github.com/MOxUnit/MOxUnit/blob/master/Makefile). Documentation tests and coverage reports are supported via [MOdox](https://github.com/MOdox/MOdox) and [MOCov](https://github.com/MOcov/MOcov).

## Usage

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

## Arguments

| Input | Description | Usage |
| - | - | - |
| `tests` | files or directories containing the MOxUnit test cases | *Optional*, defaults to the root directory of the repo. All subdirectories are added recursively. |
| `src` | directories to be added to the Octave search path before running the tests | *Optional*
| `log_file` | store the output in file output | *Optional* |
| `doc_tests` | set to `true` to run documentation tests with [MOdox](https://github.com/MOdox/MOdox) | *Optional* |
| `with_coverage` | set to `true` to record coverage using [MOCov](https://github.com/MOcov/MOcov) | *Optional* |
| `cover_xml_file` | store coverage XML output in file | *Optional* |
| `cover_html_dir` | store coverage HTML output in directory | *Optional* |
| `cover_junit_xml_file` | store test results in junit XML file | *Optional* |
| `cover_json_file` | store coverage report in json file for  processing by coveralls.io | *Optional* |
