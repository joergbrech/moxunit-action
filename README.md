# MOxUnit action

This action performs unit tests for GNU Octave and Matlab using the unit testing framework [MOxUnit](https://github.com/MOxUnit/MOxUnit/blob/master/Makefile).

## Usage

In the simplest case
```
uses: joergbrech/moxunit-action@master
```

runs all MOxUnit test cases found in this repository. A more complex use case could look like this:

```
uses: joergbrech/moxunit-action@master
with:
  tests: tests my_extra_testfile.m
  src: src thirdparty util
  with_coverage: true
  doc_tests: true
  cover_xml_file: coverage.xml

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
| `cover_junix_xml_file` | store test results in junit XML file | *Optional* |
