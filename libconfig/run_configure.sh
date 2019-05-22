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

CC="gcc -specs=${SPECS} -nostdlib" \
LDFLAGS="-L${PREFIX}/lib -Wl,-R${PREFIX}/lib" \
LIBS="-lpin3c_missing" \
./configure --prefix=${PREFIX} --disable-cxx

