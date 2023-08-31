#!/bin/bash
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=1:mem=30GB:ngpus=1:gpu_type=A100

module load CUDA

export PATH=$PATH:$HOME/go/bin

cd $PBS_O_WORKDIR

mumax3 6.mx3