# Select the type of compile
DEBUG=no
NUM_TASKS=4

# Intel compiler options
FC=ifort
FCFLAGS="-Ofast -xMIC-AVX512 -fast-transcendentals -assume buffered_io -align array64byte -mkl -I$(NETCDF)/include -ftz -no-prec-sqrt"
FC_OMP_FLAGS="-qopenmp -Ofast -xMIC-AVX512 -fast-transcendentals -assume buffered_io -align array64byte -mkl -I$(NETCDF)/include -ftz -no-prec-sqrt"
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
	cp aeroemiss/aeroemiss ../bin/
build_casafield:
	cd casafield && make -j$(NUM_TASKS) CUSTOM=yes FC=${FC} XFLAGS=${FCFLAGS} LIBS=${LIBS} PPFLAG90=${CPP} PPFLAG77=${CPP}
	cp casafield/casafield ../bin/
build_cdfvidar:
	cd cdfvidar && make -j$(NUM_TASKS) CUSTOM=yes FC=${FC} FFLAGS=${FC_OMP_FLAGS} LIBS=${LIBS} PPFLAG90=${CPP} PPFLAG77=${CPP}
	cp cdfvidar/cdfvidar ../bin/
build_igbpveg:
	cd igbpveg && make -j$(NUM_TASKS) CUSTOM=yes FC=${FC} XFLAGS=${FC_OMP_FLAGS} LIBS=${LIBS} PPFLAG90=${CPP} PPFLAG77=${CPP}
	cp igbpveg/igbpveg ../bin/
build_ocnbath:
	cd ocnbath && make -j$(NUM_TASKS) CUSTOM=yes FC=${FC} XFLAGS=${FC_OMP_FLAGS} LIBS=${LIBS} PPFLAG90=${CPP} PPFLAG77=${CPP}
	cp ocnbath/ocnbath ../bin/
build_pcc2hist:
	cd pcc2hist && make -j$(NUM_TASKS) CUSTOM=yes FFLAGS=${FC_OMP_FLAGS} LIBS=${LIBS} PPFLAG90=${CPP} 
	cp pcc2hist/pcc2hist ../bin/
build_sibveg:
	cd sibveg && make -j$(NUM_TASKS) CUSTOM=yes FC=${FC} XFLAGS=${FCFLAGS} LIBS=${LIBS} PPFLAG90=${CPP} PPFLAG77=${CPP}
	cp sibveg/sibveg ../bin/
build_terread:
	cd terread && make -j$(NUM_TASKS) CUSTOM=yes FC=${FC} XFLAGS=${FCFLAGS} LIBS=${LIBS} PPFLAG90=${CPP} PPFLAG77=${CPP}
	cp terread/terread ../bin/
build_ccam:
	cd ccam && make -j8 XEONPHI=yes OMP=yes NOMPI3=yes NETCDF_ROOT=${NETCDF} timing=yes NCMOD=yes 
	cp ccam/globpea ../bin/
