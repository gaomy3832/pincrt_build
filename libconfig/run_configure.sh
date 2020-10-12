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

if ! ls ${PREFIX}/lib/libpincrtpatch.* > /dev/null 2>&1; then
    echo "First install libpincrtpatch to ${PREFIX}/lib"
    exit 1
fi

CC="gcc -specs=${SPECS} -nostdlib -pincrtpatchpath=${PREFIX}/lib" \
./configure --prefix=${PREFIX} --disable-cxx

