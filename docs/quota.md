# Disk Quota

When you log to Trixie, you will see your disk quota as part of the login message.

```sh
Home Quota Disk Usage: 41.4%; Home Quota Inode Usage: 37.0%
Work Quota Disk Usage: 22.4%; Work Quota Inode Usage: 16.7%
Check quota limits with gpfs-quota command
```

- `Home` is `/home/$USER/`
- `Work` is `/gpfs/work/$USER/`

To get a more detailed report, run `gpfs-quota`.

```sh
Filesystem Fileset    type         blocks      quota      limit   in_doubt    grace |    files   quota    limit in_doubt    grace  Remarks
scale      share      USR               0          0          0          0     none |        1       0        0        0     none trixie3500-scale.gpfs.net
scale      home       USR           20.7G        50G        51G     426.2M     none |   369754 1000000  1100000       60     none trixie3500-scale.gpfs.net
scale      projects   USR          59.35T          0          0     1.614G     none |  9892887       0        0      419     none trixie3500-scale.gpfs.net
scale      work       USR          112.2G       500G       550G          0     none |   167220 1000000  1100000        0     none trixie3500-scale.gpfs.net
```

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
