# OOMMF Compilation

HX1 comes with Ice Lake Xeons CPUs which use the AVX-512 instruction set, while the OOMMF binary from anaconda only uses 4 CPU cores and SSE2 instruction set. Therefore, we have to compile OOMMF from source targeting the Ice Lake CPUs.


## Compile from source

1. Download the source code from NIST website
```
curl https://math.nist.gov/oommf/dist/oommf20b0_20220930.tar.gz -o oommf20b0_20220930.tar.gz
mkdir oommf
tar -xzf oommf20b0_20220930.tar.gz -C oommf
```


2. Download the modified tcl file from this repo
