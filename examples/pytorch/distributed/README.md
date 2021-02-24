# Running pytorch.distributed on Multiple Nodes

[Documented here](https://github.com/ai4d-iasc/trixie/wiki/SLURM%2C-pytorch-distributed-and-Multiple-Nodes)

Let say we want to run the following [example](https://leimao.github.io/blog/PyTorch-Distributed-Training/) on multiple nodes on trixie.
The following scripts are wrapper scripts to help start a multinode job.


## Observations

We are using two scripts because `srun` doesn't carry the conda environment to the worker node.
We could probably get away with a single script if we were not using a conda environment that we had to source.
To be confirmed but it looks like `srun trains.sh` is in fact replaced by something along the lines of:
```
foreach node in $SLURM_NODELIST; do
  ssh $node train.sh &
done
wait
```
There seem to be confusion with when a variable is evaluated.
For example, `srun train.sh $HOSTNAME` will result in expanding `$HOSTNAME` to the hostname of the master worker where as, if you want to use the worker's hostname you would have to escape your variable like so `srun train.sh \$HOSTNAME`.


## Useful Liknks

Here are links that help make this possible

* [Run PyTorch Data Parallel training on ParallelCluster](https://www.hpcworkshops.com/08-ml-on-parallelcluster/03-distributed-data-parallel.html)
* [slurm SBATCH - Multiple Nodes, Same SLURMD_NODENAME](https://stackoverflow.com/a/51356947)
