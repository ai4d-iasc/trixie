Trixie use the slurm scheduler to manage jobs.
Compute Canada has a very good guide for using slurm to submit jobs to a cluster most of which is applicable for Trixie: <https://docs.computecanada.ca/wiki/Running_jobs>

Here is a simple job which runs the python code hello.py

Contents of hello.py

```
print('Hello world')
```

Contents of hello-job.sh

```
#!/bin/bash
#SBATCH -J helloworld

module load conda/3-24.9.0
srun python ~/hello.py
```

Submit job:

```
sbatch ./hello-job.sh
```

Output will be located in slurm-`<jobid>`.out

In order for a job to run on Trixie, it must be "billed" against an approved project. Users are able to charge different projects depending on what their activity is for.

See here for the [Account Codes](Account-Codes.md)

### More jobs examples

- [jobs-conda-pytorch](Jobs-conda-pytorch.md)
- [jobs-jupyterlab](jobs-jupyterlab.md)
- [jobs-conda-RAPIDS](jobs-conda-RAPIDS.md)
- [jobs-abinit](jobs-abinit.md)
