# Disk Quotas

Users may have several quotas to manage on Trixie. At the least, each user has their own home and work disk and inode (i.e., number of files and directories) quotas. As well, depending upon the number of research groups they belong to, they will also have disk quotas under `/projects` for each group to which they belong.

When you log to Trixie, you will see your disk quota as part of the login message.

```sh
Home Quota Disk Usage: 41.4%; Home Quota Inode Usage: 37.0%
Work Quota Disk Usage: 22.4%; Work Quota Inode Usage: 16.7%
Check quota limits with gpfs-quota and gpfs-group-quota commands
```

- `Home` is `/gpfs/home/$USER` and `/home/$USER/`
- `Work` is `/gpfs/work/$USER/` and `/work/$USER`

To get a more detailed report about your user-level quotas, run `gpfs-quota`.

```sh
Filesystem Fileset    type         blocks      quota      limit   in_doubt    grace |    files   quota    limit in_doubt    grace  Remarks
scale      share      USR               0          0          0          0     none |        1       0        0        0     none trixie3500-scale.gpfs.net
scale      home       USR           20.7G        50G        51G     426.2M     none |   369754 1000000  1100000       60     none trixie3500-scale.gpfs.net
scale      projects   USR          59.35T          0          0     1.614G     none |  9892887       0        0      419     none trixie3500-scale.gpfs.net
scale      work       USR          112.2G       500G       550G          0     none |   167220 1000000  1100000        0     none trixie3500-scale.gpfs.net
```

To get a more detailed report about your group level quotas run `gpfs-group-quota`.

```sh
Disk quotas for group ai4d-cluster-aero-apdc-01-project (gid 171971877):
                         Block Limits                                               |     File Limits
Filesystem Fileset    type         blocks      quota      limit   in_doubt    grace |    files   quota    limit in_doubt    grace  Remarks
scale      projects   GRP               0       100G       100G          0     none |        1       0        0        0     none trixie3500-scale.gpfs.net

Disk quotas for group ai4d-cluster-ai4d-core-03-project (gid 171971331):
                         Block Limits                                               |     File Limits
Filesystem Fileset    type         blocks      quota      limit   in_doubt    grace |    files   quota    limit in_doubt    grace  Remarks
scale      projects   GRP               0       100G       100G          0     none |        1       0        0        0     none trixie3500-scale.gpfs.net

Disk quotas for group ai4d-cluster-ai4d-core-08-project (gid 171971449):
                         Block Limits                                               |     File Limits
Filesystem Fileset    type         blocks      quota      limit   in_doubt    grace |    files   quota    limit in_doubt    grace  Remarks
scale      projects   GRP          2.339T     2.671T     2.671T          0     none |   130669       0        0        0     none trixie3500-scale.gpfs.net

...

Disk quotas for group ai4d-cluster-covid-covid-02-project (gid 171971328):
                         Block Limits                                               |     File Limits
Filesystem Fileset    type         blocks      quota      limit   in_doubt    grace |    files   quota    limit in_doubt    grace  Remarks
scale      projects   GRP               0       100G       100G          0     none |        1       0        0        0     none trixie3500-scale.gpfs.net
```
## Requesting additional space for `/projects`
Please reach out to Research Platform Support [rps-spr@nrc-cnrc.gc.ca](mailto:rps-spr@nrc-cnrc.gc.ca?subject=Beatrix%20%2Fprojects%20quota%20request&body=%2Fprojects%20directory%3A%20%5Bput%20path%20to%20your%20directory%20here%5D%0AIncrease%20requested%3A%20%5BN%5D%20GiB%0AHas%20the%20user%20representative%20been%20consulted%3A%20%5BY%2FN%5D%0ANotes%3A%20%5BPlease%20provide%20any%20comments%2Fnotes%2Fquestions%20here%5D%0A)
to request additional space for projects. Existing quotas were based on the greater of either 100GiB or (current usage + current-usage/total-project-usage * 20TiB).

## Cleaning to Free Up Some Space

Here are some tools and hints to help you reduce space and inodes.

### Using `gdu`

[gdu](https://github.com/dundee/gdu) is a fast disk usage analyzer with console interface written in Go.

```
gdu ~ Use arrow keys to navigate, press ? for help
--- /gpfs/projects/DT/mtp/pkgs ---
  32.8 GiB ██████▍   ▏/miniforge3
  13.5 GiB ██▌       ▏/miniconda3.disabled
   4.7 GiB ▉         ▏/ollama-0.9.0
  86.0 MiB           ▏Miniforge3-Linux-x86_64.sh
  32.2 MiB           ▏/uv
  17.8 MiB           ▏/mitlm-0.4.2
  13.7 MiB           ▏/kenlm-2024-05-22

 Total disk usage: 51.1 GiB Apparent size: 50.8 GiB Items: 449164 Sorting by: size desc
```

`gdu` allows you to delete files or directories by pressing `d`.
If you are interested to find where you are losing your inodes, you can press `C` which `Sort by file count (asc/desc)`.

### `diskonaut`

[go DiskUsage(gdu)](https://github.com/dundee/gdu) is a terminal disk space navigator 🔭.

```
 Total: 55.7G (449164 files), freed: 0 | /gpfs/projects/DT/mtp/pkgs
┌────────────────────────────────────────────────┬───────────────────────────┐
│                                                │                           │
│                                                │                           │
│                                                │                           │
│                                                │                           │
│                                                │   miniconda3.disabled/    │
│                                                │                           │
│       miniforge3/ (+307991 descendants)        │                           │
│                                                │        14.0G (25%)        │
│                                                │                           │
│                  36.9G (66%)                   │                           │
│                                                │                           │
│                                                │                           │
│                                                ├──────────────────────────┬┤
│                                                │   ollama-0.9.0/ (+30)    ││
│                                                │                          ││
│                                                │        4.7G (8%)         ││
└────────────────────────────────────────────────┴──────────────────────────┴┘
(x = Small files)
 ←↓↑→/<ENTER>/<ESC>: navigate, <BACKSPACE>: del
```

### `dust`

[dust](https://github.com/bootandy/dust) is a more intuitive version of du in rust.

```
dust
4.8G             ┌── site-packages│████▒▒▒▒▒▒▒                               │   9%
4.9G           ┌─┴ python3.12     │████▒▒▒▒▒▒▒                               │  10%
4.9G         ┌─┴ lib              │████▒▒▒▒▒▒▒                               │  10%
5.0G       ┌─┴ comet-2.2.2        │████▒▒▒▒▒▒▒                               │  10%
5.7G       │     ┌── site-packages│█████▒▒▒▒▒▒                               │  11%
5.7G       │   ┌─┴ python3.12     │█████▒▒▒▒▒▒                               │  11%
5.7G       │ ┌─┴ lib              │█████▒▒▒▒▒▒                               │  11%
5.8G       ├─┴ transformers-4.44.2│█████▒▒▒▒▒▒                               │  11%
 12G     ┌─┴ envs                 │███████████                               │  25%
 13G   ┌─┴ miniconda3.disabled    │███████████                               │  26%
5.5G   │     ┌── site-packages    │█████░░░░░░░░░░░░░░░░░░░░░░               │  11%
5.5G   │   ┌─┴ python3.12         │█████░░░░░░░░░░░░░░░░░░░░░░               │  11%
5.6G   │ ┌─┴ lib                  │█████░░░░░░░░░░░░░░░░░░░░░░               │  11%
5.4G   │ │       ┌── site-packages│█████▒▒░░░░░░░░░░░░░░░░░░░░               │  11%
5.4G   │ │     ┌─┴ python3.12     │█████▒▒░░░░░░░░░░░░░░░░░░░░               │  11%
5.5G   │ │   ┌─┴ lib              │█████▒▒░░░░░░░░░░░░░░░░░░░░               │  11%
5.5G   │ │ ┌─┴ comet-2.2.2        │█████▒▒░░░░░░░░░░░░░░░░░░░░               │  11%
7.6G   │ ├─┴ envs                 │███████░░░░░░░░░░░░░░░░░░░░               │  15$
 19G   │ ├── pkgs                 │████████████████░░░░░░░░░░░               │  38%
 32G   ├─┴ miniforge3             │███████████████████████████               │  64%
 51G ┌─┴ .                        │█████████████████████████████████████████ │ 100%
```

### `uv`

`uv` is a python virtual environment manager.
It caches a lot of its downloaded libraries and this can take a lot of space and inodes.
To reclaim some space and inodes you can do

```sh
uv cache clean
```
### `ncdu`
[ncdu](https://dev.yorhel.nl/ncdu) is a nCurses terminal-user-interface which will walk the specified directory tree then provide a user interface to navigate it and display disk and inode usage.
```sh
ncdu 1.19 ~ Use the arrow keys to navigate, press ? for help
--- /home/lover/git/trixie/trixie/docs -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  692.0 KiB [##################################] /files
  280.0 KiB [#############                     ] /images
   44.0 KiB [##                                ]  BeAGoodClusterCitizen.html
   20.0 KiB [                                  ]  Trixie-Status.md
   16.0 KiB [                                  ]  File-Transfers.md
   12.0 KiB [                                  ]  quota.md
   12.0 KiB [                                  ]  Internal-Access-Setup.md
   12.0 KiB [                                  ]  jobs-jupyterlab.md
   12.0 KiB [                                  ]  External-Access-Setup.md
    8.0 KiB [                                  ]  jobs-abinit.md
    8.0 KiB [                                  ]  index.md
    8.0 KiB [                                  ]  jobs-conda-RAPIDS.md
    8.0 KiB [                                  ]  Account-Codes.md
    8.0 KiB [                                  ]  SLURM,-pytorch-distributed-and-Multiple-Nodes.md
    4.0 KiB [                                  ]  Internal-Access-Advanced-Configuration.md
    4.0 KiB [                                  ]  External-Access-Advanced-Configuration.md
    4.0 KiB [                                  ]  jobs-python-virtualenv.md
    4.0 KiB [                                  ]  Networking-and-connectivity.md
    4.0 KiB [                                  ]  Automatically-Resuming-Requeueing.md
    4.0 KiB [                                  ]  Jobs-conda-pytorch.md
    4.0 KiB [                                  ]  Hardware.md
    4.0 KiB [                                  ]  Available-Software.md
    4.0 KiB [                                  ]  External-HPC-Systems.md
*Total disk usage:   1.2 MiB   Apparent size:   1.1 MiB   Items: 53
```
