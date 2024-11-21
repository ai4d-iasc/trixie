# Running pytorch.distributed on Multiple Nodes

Key thing to know is that srun is like a super-ssh which means that when running `srun cmd` it actually does something like `ssh node cmd`

## task.slurm

```bash
#!/bin/bash

#SBATCH --partition=TrixieMain
#SBATCH --account=dt-mtp
#SBATCH --time=00:20:00
#SBATCH --job-name=pytorch.distributed
#SBATCH --comment="Helping Harry with pytorch distributed on multiple nodes."
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
```

## task.sh

This script will be executed on each node.
Note that we are activating the `conda` environment in this script so that each node/worker can have the proper environment.

```bash
#!/bin/bash

# USEFUL Bookmarks
# [Run PyTorch Data Parallel training on ParallelCluster](https://www.hpcworkshops.com/08-ml-on-parallelcluster/03-distributed-data-parallel.html)
# [slurm SBATCH - Multiple Nodes, Same SLURMD_NODENAME](https://stackoverflow.com/a/51356947)

#module load conda/3-24.9.0
#source activate molecule

source /gpfs/projects/DT/mtp/WMT20/opt/miniforge3/bin/activate
conda activate pytorch-1.7.1

readonly MASTER_ADDR_JOB=$1
readonly MASTER_PORT_JOB=$2

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

env

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
```

