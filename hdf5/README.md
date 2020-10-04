Edit and configure step.

    ../run_configure.sh

Make step.

    make -j -l16

Test step.

    PIN_CRT_TZDATA=${PINPATH}/extras/crt/tzdata make check

There is a known issue that dlopen() in PinCRT is not implemented. So any test
using dlopen() to load shared libraries dynamically will fail. To bypass them:

- in `test/Makefile`, change the line
  `am__append_1 = test_filter_plugin.sh` to `am__append_1 =`
- in `tools/test/h5diff/Makefile`, `tools/test/h5dump/Makefile`,
  `tools/test/h5ls/Makefile`, and `tools/test/h5repack/Makefile`
  (identified by `grep "^am__append_1 =" . -r | grep plugin`),
  change the line
  `am__append_1 = h5??_plugin.sh` to `am__append_1 =`

Install step.

    make install

Install check step.

    make check-install

