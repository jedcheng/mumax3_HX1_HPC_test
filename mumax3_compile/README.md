# Mumax3 Compilation

HX1 is the latest HPC at Imperial College with 60 A100 GPUs. To leverage these GPUs, one has to be aware of the following:

1. We have to recompile Mumax3 from source targeting the Ampere architecture (sm_80).
2. Since there are only 60 A100s, we should only use A100 if the simulation scale is large enough. Otherwise, we should go back to use the Quadro RTX6000 in CX3. 




## Compile from source

1. Git clone the source code and then my repo
```
module load git 
git clone https://github.com/mumax/3
git clone https://github.com/jedcheng/mumax3_HX1_HPC_test
```

2. CD into the directory
```
cd mumax3_HX1_HPC_test/mumax3_compile
```

3. Submit the compile job
```
qsub -q hx compile.sh
```

4. Check if the compilation is successful. There should be a binary file called `mumax3` in the Go file in the $HOME/go/bin directory. If not, find the go directory yourself. 


5. Test the binary file with some test scripts. It is taken from my [reservoir computing project](https://github.com/jedcheng/spin-torque-oscillators-reservoir-computing/tree/main). It consists of 2e5 cells and runs for 3000ns. If I recall correctly, it took around 60 hours to run on 1 Quadro RTX6000. 
```
curl https://raw.githubusercontent.com/jedcheng/spin-torque-oscillators-reservoir-computing/main/scripts/6.mx3 -o 6.mx3
```
Note: 
The admin for some reason didn't install wget and has very little interest in doing so. I can include this mx3 script in this repo but I think this is a good way of showing how to download a file using curl instead of wget.

6. Submit the job.
```
qsub -q hx test_run.sh
```

Note:
The script contains a line

```
export PATH=$PATH:$HOME/go/bin
```

so that the mumax3 binary file can be found. Change the path if you have a different go directory.