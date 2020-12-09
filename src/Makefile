# Select the type of compile
DEBUG=no
NUM_TASKS=4

# Intel compiler options
FC=ifort
FCFLAGS="-Ofast -xMIC-AVX512 -I$(NETCDF)/include"
FC_OMP_FLAGS="-Ofast -qopenmp -xMIC-AVX512 -I$(NETCDF)/include"
LIBS="-L$(NETCDF)/lib -lnetcdf -lnetcdff"
CPP=-fpp

ifeq ($(DEBUG),yes)
FCFLAGS="-O1 -xMIC-AVX512 -I$(NETCDF)/include -check all -debug all -traceback -fpe0"
endif

.PHONY: cleanall buildall

cleanall: clean_aeroemiss clean_casafield clean_cdfvidar clean_igbpveg clean_ocnbath clean_pcc2hist clean_sibveg clean_terread clean_ccam

clean_aeroemiss:
	cd aeroemiss && make clean
clean_casafield:
	cd casafield && make clean
clean_cdfvidar:
	cd cdfvidar && make clean
clean_igbpveg:
	cd igbpveg && make clean
clean_ocnbath:
	cd ocnbath && make clean
clean_pcc2hist:
	cd pcc2hist && make clean
clean_sibveg:
	cd sibveg && make clean
clean_terread:
	cd terread && make clean
clean_ccam:
	cd ccam && make clean

buildall: build_aeroemiss build_casafield build_cdfvidar build_igbpveg build_ocnbath build_sibveg build_terread

build_aeroemiss:
	cd aeroemiss && make -j$(NUM_TASKS) CUSTOM=yes FC=${FC} XFLAGS=${FC_OMP_FLAGS} LIBS=${LIBS} PPFLAG90=${CPP} PPFLAG77=${CPP}
build_casafield:
	cd casafield && make -j$(NUM_TASKS) CUSTOM=yes FC=${FC} XFLAGS=${FCFLAGS} LIBS=${LIBS} PPFLAG90=${CPP} PPFLAG77=${CPP}
build_cdfvidar:
	cd cdfvidar && make -j$(NUM_TASKS) CUSTOM=yes FC=${FC} FFLAGS=${FC_OMP_FLAGS} LIBS=${LIBS} PPFLAG90=${CPP} PPFLAG77=${CPP}
build_igbpveg:
	cd igbpveg && make -j$(NUM_TASKS) CUSTOM=yes FC=${FC} XFLAGS=${FC_OMP_FLAGS} LIBS=${LIBS} PPFLAG90=${CPP} PPFLAG77=${CPP}
build_ocnbath:
	cd ocnbath && make -j$(NUM_TASKS) CUSTOM=yes FC=${FC} XFLAGS=${FC_OMP_FLAGS} LIBS=${LIBS} PPFLAG90=${CPP} PPFLAG77=${CPP}
build_pcc2hist:
	cd pcc2hist && make -j$(NUM_TASKS) CUSTOM=yes FFLAGS=${FC_OMP_FLAGS} LIBS=${LIBS} PPFLAG90=${CPP} 
build_sibveg:
	cd sibveg && make -j$(NUM_TASKS) CUSTOM=yes FC=${FC} XFLAGS=${FCFLAGS} LIBS=${LIBS} PPFLAG90=${CPP} PPFLAG77=${CPP}
build_terread:
	cd terread && make -j$(NUM_TASKS) CUSTOM=yes FC=${FC} XFLAGS=${FCFLAGS} LIBS=${LIBS} PPFLAG90=${CPP} PPFLAG77=${CPP}
build_ccam:
	cd ccam && make XEONPHI=yes OMP=yes NETCDF_ROOT=${NETCDF} 
