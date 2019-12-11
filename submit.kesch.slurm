#!/bin/bash
#SBATCH --job-name=NAME
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --output=ooo.log
#SBATCH --time=00:30:00
#SBATCH --gres=gpu:1
#SBATCH --partition=debug
#SBATCH --account=s83

########################################################

set -x
#We have to source the appropiate module_xxx.env before launching this submit script
source /scratch/cosuna/cosmo-pompa/dycore/modules_cpp.env
module list -l

ldd $BINNAME

export OMP_NUM_THREADS=1
export MALLOC_MMAP_MAX_=0
export MALLOC_TRIM_THRESHOLD_=536870912
export MV2_USE_GPUDIRECT=0 #with this perf are ok

ldd /scratch/cosuna/cosmo-pompa/dycore/build/src/dycore_unittest/DycoreUnittestCUDA

srun -n 1 /scratch/cosuna/cosmo-pompa/dycore/build/src/dycore_unittest/DycoreUnittestCUDA -p /scratch/jenkins/data/double/diff1

########################################################
