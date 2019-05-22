Install libraries with Intel Pin CRT
====================================

Starting from Pin 3, Pin requires all dependencies of pintools, such as
third-party libraries, to be rebuilt with its own runtime, a.k.a., PinCRT
[[1](https://software.intel.com/sites/default/files/managed/8e/f5/PinCRT.pdf)].
These scripts provide an automatic flow for this purpose, through the use of
GCC's spec files [[2](https://gcc.gnu.org/onlinedocs/gcc/Spec-Files.html)].

PinCRT requirements
---

1. to set special compiler flags;

2. to include special system headers, instead of standard headers;

3. to set special link flags;

4. to link only with given runtime libraries, without standard libraries.

GCC's spec file
---

1. change the `cc1` rule, by renaming it and adding more flags.

2. add the header paths with `-isystem` in the `cc1` rule.

3. create a new rule `pincrt_link` for link flags, and modify the
   `link_command` rule to use it.

4. create new rules `pincrt_startfile`, `pincrt_endfile`, `pincrt_libs`, and
   modify the `link_command` rule to use them. Also, use `%:remove-outfile()`
   function to remove the standard libraries.

Install path
---

The install path is set to be the parent directory of the top directory. In
another word, this directory should be the `src` directory besides `include`,
`lib`, etc..

