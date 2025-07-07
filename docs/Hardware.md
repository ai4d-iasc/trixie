# Hardware

Trixie is a GPU cluster consisting of 36 nodes, each with NVIDIA V100 GPU, a fast, Infiniband Interconnect, and a large 1 PB global filesystem

## Operating system

Runs RHEL 9

## Job scheduler

https://slurm.schedmd.com
`slurm 22.05.9`
(for example run scripts on Trixie see [Running-jobs](Running-jobs.md))

## Headnode (2 available)

* processor_type = Intel Xeon Gold 6130 CPU clocked at 2.1GHZ 16 cores / CPU
* processors_per_node = 2
* RAM = 96 GB memory

## Node Profile

* processor_type = Intel Xeon Gold 6130 CPU clocked at 2.1GHZ 16 cores / CPU
* processors_per_node = 2
* cores_per_socket = 16
* threads_per_core = 2 (hyper-threading on)
* RAM = 192 GB memory
* GPU_type = NVidia V100 GPUs with 32 GB RAM / GPU
* GPU_details = https://www.nvidia.com/en-us/data-center/tesla-v100/Nodes
* GPU_per_node = 4
* local scratch size =

## Filesystem

* 1 PB of GPFS storage total, with the following mount points and quotas
* /home/usernameUser space. Not backed up. Soft quota 1 TB.
* /gpfs/projects/PROGRAM/project_idShared space for sharing files between users within a project. Each project has a default quota of 1 TB. If additional space is needed
  projects can make an official request. Space is not backed up.
* /gpfs/scratch/
  User controlled scratch space for running jobs. Not backed up. Subject to Purge policy (LINK LOST)
