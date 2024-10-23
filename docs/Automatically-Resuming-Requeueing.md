# How to I get my job to requeue after my time limit?

  Here’s a skeleton of what our jobs look like.  Please check your job once it is running to dial down the number of cpus and memory needed.  If we don’t use the node’s full resources, it would be nice to be able to submit other cpu-only jobs, aka none gpu jobs on those nodes.

Important steps in order to get automatic requeueing working:
* Ask slurm to send you a signal 30 seconds before the end of your time limit `--signal=B:USR1@30`
* Have a thread listen to the requested signal `trap _requeue USR1`
* **Send your MAIN process in the background and wait for it otherwise your `_requeue` function will NEVER get a chance to run.**


```
#SBATCH --job-name=WMT21.training
#SBATCH --comment="Thanks Samuel Larkin for showing me how to work with Slurm"

#SBATCH --partition=TrixieMain
#SBATCH --account=dt-mtp
#SBATCH --gres=gpu:4
#SBATCH --time=12:00:00                                                                                                                                                      #SBATCH --exclude=cn125
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1                                                                                                                                                  #SBATCH --cpus-per-task=24
#SBATCH --mem=40G
# To reserve a whole node for yourself
####SBATCH --exclusive
#SBATCH --open-mode=append
#SBATCH --requeue
#SBATCH --signal=B:USR1@30
#SBATCH --output=%x-%j.out                                                                                                                                                   

# Requeueing on Trixie
# [source](https://www.sherlock.stanford.edu/docs/user-guide/running-jobs/)
# [source](https://hpc-uit.readthedocs.io/en/latest/jobs/examples.html#how-to-recover-files-before-a-job-times-out)
function _requeue {
   echo "BASH - trapping signal 10 - requeueing $SLURM_JOBID"
   date
   # This would allow to generically requeue any job but since we are using XLM
   # which is slurm aware, XLM could save its model before requeueing.
   scontrol requeue $SLURM_JOBID
}

if [[ -n "$SLURM_JOBID" ]]; then
   trap _requeue USR1
fi


time python –m sockeye.train …. &
wait
```

where `time python –m sockeye.train ….` is the process you want to run.