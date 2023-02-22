# v1.3
## 2023/02/22

Contributors: Contributors: [Remi-Gau](https://github.com/Remi-Gau), [jorgepz](https://github.com/jorgepz)

 - Update documentation in Readme
 - Update Dockerfile to use `qmrlab/octaveci:latest` based on Octave 5.2.0 [#12](https://github.com/joergbrech/moxunit-action/issues/12)

# v1.2
## 2021/08/17

Contributors: [Remi-Gau](https://github.com/Remi-Gau), [jorgepz](https://github.com/jorgepz), [agahkarakuzu](https://github.com/agahkarakuzu)

 - Bugfix: Allow several external directories to be added [#10](https://github.com/joergbrech/moxunit-action/issues/10)
 - Make sure that `@v1` points to the latest major version [#11](https://github.com/joergbrech/moxunit-action/issues/11)
 - New option to provide a working directory [#11](https://github.com/joergbrech/moxunit-action/issues/22)
 - Use `qmrlab/octaveci:v4.2.2` instead of `mtmiller/octave` as base docker image [#6](https://github.com/joergbrech/moxunit-action/issues/6)
 - Add optional test data directory [#6](https://github.com/joergbrech/moxunit-action/issues/6)
 - Add option to install octave packages [#6](https://github.com/joergbrech/moxunit-action/issues/6)
 - Add option to add external packages to the search path [#6](https://github.com/joergbrech/moxunit-action/issues/6)

# v1.1
## 2020/03/27

 - Rename argument `test_directory` to `tests` **breaks backward compatibility!**
 - Rename argument `src_directory` to `src` **breaks backward compatibility!**
 - Add support for writing to a logfile
 - Add support for several src directories
 - Add support for several test directories
 - recurse into subdirectories by default
 - Add support for documentation tests with Modox
 - Add support for code coverage and coverage reports with MOcov

# v1
## 2020/03/24

Initial release
