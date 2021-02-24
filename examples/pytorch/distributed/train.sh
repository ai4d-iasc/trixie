#!/bin/bash

# USEFUL Bookmarks
# [Run PyTorch Data Parallel training on ParallelCluster](https://www.hpcworkshops.com/08-ml-on-parallelcluster/03-distributed-data-parallel.html)
# [slurm SBATCH - Multiple Nodes, Same SLURMD_NODENAME](https://stackoverflow.com/a/51356947)

module load miniconda3-4.7.12.1-gcc-9.2.0-j2idqxp
conda activate pytorch-1.7.1

readonly MASTER_ADDR_JOB=$1
readonly MASTER_PORT_JOB=$2

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

python \
   -m torch.distributed.launch \
      --nproc_per_node=4 \
      --nnodes=$SLURM_NTASKS \
      --node_rank=$SLURM_NODEID \
      --master_addr=$MASTER_ADDR_JOB \
      --master_port=$MASTER_PORT_JOB \
      main.py \
         --batch_size 128 \
         --learning_rate 5e-5 &

wait
