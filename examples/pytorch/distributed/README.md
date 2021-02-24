# Running pytorch.distributed on Multiple Nodes

[Documented here](https://github.com/ai4d-iasc/trixie/wiki/SLURM%2C-pytorch-distributed-and-Multiple-Nodes)

Let say we want to run the following [example](https://leimao.github.io/blog/PyTorch-Distributed-Training/) on multiple nodes on trixie.
The following scripts are wrapper scripts to help start a multinode job.

## Useful Liknks

Here are links that help make this possible

* [Run PyTorch Data Parallel training on ParallelCluster](https://www.hpcworkshops.com/08-ml-on-parallelcluster/03-distributed-data-parallel.html)
* [slurm SBATCH - Multiple Nodes, Same SLURMD_NODENAME](https://stackoverflow.com/a/51356947)
