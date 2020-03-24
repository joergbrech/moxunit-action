# MOxUnit action

This action performs unit tests for Octave/Matlab using [MOxUnit](https://github.com/MOxUnit/MOxUnit/blob/master/Makefile)

## Inputs

### `test_directory`

**Required** The directory containing the MOxUnit test cases. Default `.`.

### `src_directory`

**Required** The directory of the source code. Default `.`.

## Example usage

```
uses: joergbrech/moxunit-action@v1
with:
  test_directory: 'tests'
  src_directory: 'src'
```