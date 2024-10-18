This examples will show you how to setup and prepare an environment for Abinit jobs using conda on Trixie:

### 1. Use existing miniconda install of abinit:

```bash
#!/bin/bash
# load spack
module load spack
# load the miniconda module
module load miniconda3-4.8.2-gcc-9.2.0-sbqd2xu
# create a conda environment named abinit 
conda create --name abinit python=3.7
source activate abinit
# install pytorch dependencies via conda
conda install abinit cudatoolkit=10.1 -c 
```

### 2. Copy / create a test abinit file: Si_208.files

```bash
cd $work_dir; cat <<_EOF_ >Si_208.files
Si_208.in
Si_208.out
Si_208
tmp
Si_208
14-Si.LDA.fhi
_EOF_
```

### 3(a). Create a job submission script: test_abinit.sh

```bash
#!/bin/bash
#SBATCH --nodes=8             # <-- request # nodes from cluster partition
##BATCH --ntasks-per-node=1   # <-- request # tasks per node (default 1 cpu/task)
#SBATCH --cpus-per-task=8     # <-- request # cpus/task (OMP_NUM_THREADS)
#SBATCH --mem=24000           # <-- request 24000MB to run this job.
#SBATCH --time=160            # <-- request secs of wallclock/run.
#SBATCH -p TrixieMain         # <-- partition
# 
export HOSTFILE="/tmp/hosts.$SLURM_JOB_ID"
srun hostname -s > $HOSTFILE
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# --- Set the working directory using full path ---
work_dir="/gpfs/share/opt/apps/abinit/examples/Si_208"
# --- Set the input filename for the abinit program (full path)
files="$work_dir/Si_208.files"

echo "Loading.. "
echo spack load miniconda3
spack load miniconda3@4.8.2
echo . activate abinit
. activate /gpfs/share/opt/apps/abinit/conda/envs/abinit
echo which abinit
which abinit

#  Set the abinit program using full path:
bin=`which abinit`
if [ $? -ne 0 ]; then
    echo "abinit program not found!"
    exit 1
fi
if [ ! -x $bin ]; then
    echo "$bin not found!"
    exit 1
fi

# --- Sleep to make sure loaded properly on all nodes ---
sleep 10

# --- Start MPI jobs ---
set -x
which mpirun

if [ -z "$SLURM_NPROCS" ]; then
   if [ -z "$SLURM_NTASKS_PER_NODE" ]; then
        SLURM_NTASKS_PER_NODE=1
   fi
   SLURM_NPROCS=$[ $SLURM_JOB_NUM_NODES * $SLURM_NTASKS_PER_NODE ]
fi

mpirun -f $HOSTFILE -n $SLURM_NPROCS -launcher ssh -wdir $work_dir $bin < $files

test -r $HOSTFILE && rm $HOSTFILE
# -----------------------------------------------------------------------------
```

### 3(b). _OR_ Module load abinit from CC stack:

```bash
$ module avail abinit

-------------------------------- MPI-dependent avx512 modules ---------------------------------
   abinit/8.4.4 (chem)    abinit/8.10.2 (chem)    abinit/9.2.1 (chem,D)

  Where:
   chem:  Chemistry libraries/apps / Logiciels de chimie
   D:     Default Module

$ module load abinit/8.10.2
```

```bash
#
#  abinit_template_slurm.job
#
#  Set scheduler parameters
# -----------------------------------------------------------------------------
#  --- Send email to address defined below when job is completed or aborted ---
#SBATCH --mail-type=abort,end
#
#  --- Please replace with your email ---
#SBATCH --mail-user=First.Lastname@cnrc-nrc.gc.ca
#
#  The next options define the running environment requested for this job.
# -----------------------------------------------------------------------------
#SBATCH --nodes=8             # <-- request # nodes from cluster partition
#SBATCH --ntasks-per-node=1   # <-- request # tasks per node (default 1 cpu/task)
#SBATCH --cpus-per-task=8     # <-- request # cpus/task (OMP_NUM_THREADS)
#SBATCH --mem=24000           # <-- request 24000MB to run this job.
#SBATCH --time=160            # <-- request secs of wallclock/run.
#
#SBATCH -p TrixieMain         # <-- partition
#
# -----------------------------------------------------------------------------
#

# --- Set the working directory using full path ---
work_dir="/gpfs/share/opt/apps/abinit/examples/Si_208"
# --- Set the input filename for the abinit program (full path)
files="$work_dir/Si_208.files"

module load abinit/8.10.2

bin=`which abinit`


if [ -z "$SLURM_NPROCS" ]; then
   if [ -z "$SLURM_NTASKS_PER_NODE" ]; then
        SLURM_NTASKS_PER_NODE=1
   fi
   SLURM_NPROCS=$[ $SLURM_JOB_NUM_NODES * $SLURM_NTASKS_PER_NODE ]
fi

mpirun -n $SLURM_NPROCS -wdir $work_dir $bin < $files

```

CC stack cannot yet module load abinit/9.2.1 (default module), as the StdEnv/2020 and libxc/5.0.0 are required for that module. There is no abinit/9.2.1 built using gcc/9.3.0, rather only intel compiler. Instead load the current supported version tested on trixie:

Attempt to load abinit/9.2.1 w/ older env:
```bash
$ module spider abinit/9.2.1
$ module load       nixpkgs/16.09  intel/2018.3  openmpi/3.1.4
$ module load abinit/9.2.1 
$ which abinit
/cvmfs/soft.computecanada.ca/easybuild/software/2017/avx512/MPI/intel2018.3/openmpi3.1/abinit/9.2.1/bin/abinit

```

### 4. Submit job for execution:
```bash
sbatch test_abinit.sh
```

Output will be '**Submitted batch job XXXXX**'

### 5. Confirm execution results:
Local directory will contain a file '**slurm-XXXXX.out**' which is the output of the job (stdout).

Output should be:
```
cnNNN
cnNNN
..
Loading.. 
spack load miniconda3@4.8.2
. activate abinit
which abinit
/gpfs/share/opt/apps/abinit/conda/envs/abinit/bin/abinit
+ which mpirun
/gpfs/share/opt/apps/abinit/conda/envs/abinit/bin/mpirun
+ mpirun -f /tmp/hosts.61574 -n 8 -launcher ssh -wdir /gpfs/share/opt/apps/abinit/examples/Si_208 /gpfs/share/opt/apps/abinit/conda/envs/abinit/bin/abinit
  ABINIT 9.0.4
```

