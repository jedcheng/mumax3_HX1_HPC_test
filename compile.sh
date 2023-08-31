#!/bin/bash
#PBS -l walltime=01:00:00
#PBS -l select=1:ncpus=4:mem=20GB:ngpus=1:gpu_type=A100


module load Go/1.20.4
module load buildenv/default-foss-2022a
module load CUDA/12.2.0

cd $HOME/3
make CUDA_CC=80
cd cmd/mumax3
go install