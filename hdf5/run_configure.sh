echo "Pin path is ${PINPATH}"

TOP=$(readlink -f ../..)

PREFIX=$(readlink -f ${TOP}/..)
echo "Install path is set to ${PREFIX}"

SPECS=${TOP}/gcc_scripts/specs.pincrt
echo "GCC spec file is ${SPECS}"
if [ ! -f ${SPECS} ]; then
    echo "GCC spec file does not exist!"
    exit 1
fi

# Add to the end of src/H5private.h
#  #undef STATIC
# This is because ${PINPATH}/extras/crt/include/types_marker.h has defined
# STATIC to be static, which makes macro glue fail in HDF5.
sed -i "$(($(wc -l < 'src/H5private.h')-2)) i #undef STATIC" ./src/H5private.h || exit 1

# In test/tcheck_version.c, rename the global variables
#  major
#  minor
# Because ${PINPATH}/extras/crt/include/sys/sysmacros.h has defined them as
# functions.
sed -i -e "s/major/_major/g" -e "s/minor/_minor/g" ./test/tcheck_version.c || exit 1

# Depends on zlib.h
CC="gcc -specs=${SPECS} -nostdlib" \
CFLAGS="-I${PREFIX}/include" \
LDFLAGS="-L${PREFIX}/lib -Wl,-R${PREFIX}/lib" \
LIBS="-lpin3c_missing" \
./configure --prefix=${PREFIX}

# PinCRT rand_r() is not actually random, will generate even and odd numbers
# alternatively. random() is much better.
sed -i -e "/H5_HAVE_RAND_R/ c \/* #undef H5_HAVE_RAND_R *\/" ./src/H5pubconf.h || exit 1
sed -i -e "/HAVE_RAND_R/ c \/* #undef HAVE_RAND_R *\/" ./src/H5config.h || exit 1

# PinCRT does not provide actual implementations for dlopen, dlsym, dlclose, etc.
sed -i -e "/H5_HAVE_LIBDL/ c \/* #undef H5_HAVE_LIBDL *\/" ./src/H5pubconf.h || exit 1
sed -i -e "/HAVE_LIBDL/ c \/* #undef HAVE_LIBDL *\/" ./src/H5config.h || exit 1

