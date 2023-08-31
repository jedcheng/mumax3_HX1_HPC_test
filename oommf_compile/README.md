# OOMMF Compilation

HX1 comes with Ice Lake Xeons CPUs which use the AVX-512 instruction set, while the OOMMF binary from anaconda only uses 4 CPU cores and no AVX-512. Therefore, we have to compile OOMMF from source targeting the Ice Lake CPUs.


## Compile from source

1. Download the source code from NIST website. For convenience, I would start at $HOME directory.
```
cd
curl https://math.nist.gov/oommf/dist/oommf20b0_20220930.tar.gz -o oommf20b0_20220930.tar.gz
mkdir oommf
tar -xzf oommf20b0_20220930.tar.gz oommf
```


2. Download the modified tcl file from this repo. This file is modified to use AVX512, NUMA and 128 threads. 
```
curl https://raw.githubusercontent.com/jedcheng/mumax3_HX1_HPC_test/main/oommf_compile/linux-x86_64.tcl -o linux-x86_64.tcl

mv linux-x86_64.tcl oommf/config/platforms/
```

Note:
The CPU nodes do not have hyperthreading enabled (i.e 64 threads only). But OOMMF typically uses 50% of each thread, so we can use 128 threads to fully utilise the CPU. I observed no difference between setting the number of threads to 64 or 128.



3. Load the required modules
```
module load intel
module load buildenv/default-foss-2022a
module load Tk
```

4. Compile
```
tclsh oommf.tcl pimake upgrade
tclsh oommf.tcl pimake distclean
tclsh oommf.tcl pimake
```



## How to run OOMMF?

It is not easy to run I would say. Fortunately, one could use [Ubermag](https://ubermag.github.io/index.html) to interact with OOMMF. And I will show you how to do so.


1. Create a python virtual environment
```
module load Python
python -m venv oommf_env
source oommf_env/bin/activate
```

2. Install Ubermag
```
module load SciPy-bundle
pip install ubermag
pip install matplotlib
```

3. Run the test script. The test script is a standard problem 4 I found from Ubermag site, which I modified to make the system larger and run longer.
```
cd mumax3_HX1_HPC_test/oommf_compile
qsub -q hx test_run.sh
```


## Performance Note

As I suggested numerous times, 3D FFT at large scale is seriously bottlenecked by memory bandwidth instead of compute. OOMMF on HX1 can go head-to-head with an Nvidia Tesla T4 (8.141 TFLOPS, 320 GB/s) running the standard problem 4 at 100nmx1000nm with Mumax3 in terms of performance. But got demolished when I switched to an Nvidia Tesla V100 (15.67 TFLOPS, 900 GB/s) that ran 2-4 times faster. 



The Quadro RTX6000 is roughly the same as a V100. There is not much point in using OOMMF on HX1 unless you are running a small system or HX1 allows you to access more than 16 nodes at the same time (which is the limit for GPU nodes on CX3).


The AMD Nodes on CX3 have 128 cores per node but no AVX-512. I would like to test it out but I couldn't compile OOMMF on the AMD nodes. 


I am not sure if single node jobs would be provisioned to these Intel nodes on HX1 after deployment. If not, then there is no point in using OOMMF at all.
