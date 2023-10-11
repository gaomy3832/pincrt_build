Source link: https://tls.mbed.org/
Download archive: https://tls.mbed.org/download-archive

No configure step.

Edit and make step.

    ../run_make.sh -j16

Test step.

    LD_LIBRARY_PATH=library:$LD_LIBRARY_PATH ./programs/test/selftest

Install step.

    make install

