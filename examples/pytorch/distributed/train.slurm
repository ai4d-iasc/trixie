#!/bin/bash

#SBATCH --partition=TrixieMain
#SBATCH --account=dt-mtp
#SBATCH --time=00:20:00
#SBATCH --job-name=pytorch.distributed
#SBATCH --comment="Samuel helping Harry with pytorch distributed on multiple nodes."
#SBATCH --gres=gpu:4
##SBATCH --ntasks=2

#SBATCH --wait-all-nodes=1
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=6
#SBATCH --exclusive
#SBATCH --output=%x-%j.out


# USEFUL Bookmarks
# [Run PyTorch Data Parallel training on ParallelCluster](https://www.hpcworkshops.com/08-ml-on-parallelcluster/03-distributed-data-parallel.html)
# [slurm SBATCH - Multiple Nodes, Same SLURMD_NODENAME](https://stackoverflow.com/a/51356947)

readonly MASTER_ADDR_JOB=$SLURMD_NODENAME
readonly MASTER_PORT_JOB="12234"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

readonly srun='srun --output=%x-%j.%t.out'

env

$srun bash \
   task.sh \
      $MASTER_ADDR_JOB \
      $MASTER_PORT_JOB &

wait
