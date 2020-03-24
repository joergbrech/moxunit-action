# MOxUnit action

This action performs unit tests for GNU Octave and Matlab using the unit testing framework [MOxUnit](https://github.com/MOxUnit/MOxUnit/blob/master/Makefile).

## Inputs

### `test_directory`

**Required** The directory containing the MOxUnit test cases. Default is the root of the repository.

### `src_directory`

**Required** The directory of the source code. Default is the root of the repository.

## Example usage

```
uses: joergbrech/moxunit-action@master
with:
  test_directory: tests
  src_directory: src
```