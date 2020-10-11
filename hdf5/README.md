Source link: https://www.hdfgroup.org/solutions/hdf5/

Edit and configure step.

    ../run_configure.sh

Make step.

    make -j -l16

Test step.

    PIN_CRT_TZDATA=${PINPATH}/extras/crt/tzdata make check

Install step.

    make install

Install check step.

    make check-install

