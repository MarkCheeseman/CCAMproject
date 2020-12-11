# CCAMproject

This repository includes a full build of the [Conformal Cubic Atmospheric Model](https://confluence.csiro.au/display/CCAM/Getting+started "CCAM website") and all of its associated pre and post-processing tools.

## Building the executables

It's assumed that you are using an Intel compiler suite for the build.

```bash
cd src
make buildall
```

You may wish to do a clean and if you want a fresh rebuild

```bash
cd src
make -j9 cleanall
```

Don't worry about the error messages about not finding any core files.
