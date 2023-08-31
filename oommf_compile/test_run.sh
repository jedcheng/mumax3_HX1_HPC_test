#!/bin/bash
#PBS -l walltime=03:00:00
#PBS -l select=1:ncpus=64:mem=500gb
  
  
module load intel
module load Python


export OOMMFTCL="$HOME/oommf/oommf.tcl"
source $HOME/oommf_env/bin/activate


cd $PBS_O_WORKDIR
python test_std4_1000x1000.py