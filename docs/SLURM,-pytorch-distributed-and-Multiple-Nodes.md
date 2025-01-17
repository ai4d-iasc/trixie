# Running pytorch.distributed on Multiple Nodes

Key thing to know is that srun is like a super-ssh which means that when running `srun cmd` it actually does something like `ssh node cmd`

## Initial Solution

### task.slurm

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

### task.sh

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

## Accelerate/HuggingFace Specific

```sh
#!/bin/bash

# [SLURM/ACCELERATE](https://github.com/huggingface/accelerate/blob/main/examples/slurm/submit_multinode.sh)
# [MNIST](https://huggingface.co/blog/pytorch-ddp-accelerate-transformers)

#SBATCH --partition=TrixieMain
#SBATCH --account=dt-mtp

#SBATCH --time=12:00:00
#SBATCH --job-name=MNIST.distributed
#SBATCH --gres=gpu:4
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8

#SBATCH --output=%x-%j.out
#SBATCH --signal=B:USR1@30
#SBATCH --requeue

# Requeueing on Trixie
# [source](https://www.sherlock.stanford.edu/docs/user-guide/running-jobs/)
# [source](https://hpc-uit.readthedocs.io/en/latest/jobs/examples.html#how-to-recover-files-before-a-job-times-out)

function _requeue {
   echo "BASH - trapping signal 10 - requeueing $SLURM_JOBID"
   date
   # This would allow to generically requeue any job but since we are using XLM
   # which is slurm aware, XLM could save its model before requeueing.
   scontrol requeue "$SLURM_JOBID"
}

if [[ -n "$SLURM_JOBID" ]]; then
   trap _requeue USR1
fi


# Keep a copy of the code in case it changes between runs.
head -n 112312 "$0" my_huggingface_trainer.py

# Setup your working environment.
source setup_env.sh ""

# These are required to setup the distributed framework.
head_node_ip=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
head_node_port=29507  # You can choose your own port

# Dump the environment.
( set -o posix ; set )


srun accelerate launch \
  --num_processes=$((SLURM_NNODES * SLURM_GPUS_ON_NODE)) \
  --num_machines="$SLURM_NNODES" \
  --rdzv_backend=c10d \
  --main_process_ip="$head_node_ip" \
  --main_process_port="$head_node_port" \
  --machine_rank="$SLURM_NODEID" \
  my_huggingface_trainer.py
```
