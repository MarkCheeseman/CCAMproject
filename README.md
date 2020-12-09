# CCAMproject

This repository includes a full build of the [Conformal Cubic Atmospheric Model](https://confluence.csiro.au/display/CCAM/Getting+started "CCAM website") and all of its associated pre and post-processing tools.

## Building the executables

We assume you are running on one of DUG's platforms and that you will be using the Intel compilers for the build.

```bash
module use /p9/dug/teamhpc/tests_for_candidate/markc/modulefiles
module load openmpi/4.0.5-hpcx-icc hdf5/1.10.7 netcdf/4.7.4
cd src
make buildall
```

