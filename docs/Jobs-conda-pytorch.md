This examples will show you how to setup and prepare an environment for PyTorch jobs using conda on Trixie:

### 1. Create a pytorch miniconda environment:
Either run from the command line or create pytorchconda-environment.sh and run it:

```bash
#!/bin/bash
# load the miniconda module
module load miniconda3-4.8.2-gcc-9.2.0-sbqd2xu
# create a conda environment with python 3.7 named pytorch
conda create --name pytorch python=3.7
source activate pytorch
# install pytorch dependencies via conda
conda install pytorch==1.7.1 torchvision==0.8.2 cudatoolkit=10.1 -c pytorch
```

### 2. Create a test pytorch python script: testtorch.py

```python
import torch
print('GPU available:', torch.cuda.is_available())
```

### 3. Create a job submission script: testpytorch.sh

```bash
#!/bin/bash

# Specify the partition of the cluster to run on (Typically TrixieMain)
#SBATCH --partition=TrixieMain
# Add your project account code using -A or --account
#SBATCH --account ai4d
# Specify the time allocated to the job. Max 12 hours on TrixieMain queue.
#SBATCH --time=12:00:00
# Request GPUs for the job. In this case 4 GPUs
#SBATCH --gres=gpu:4
# Print out the hostname that the jobs is running on
hostname
# Run nvidia-smi to ensure that the job sees the GPUs
/usr/bin/nvidia-smi

# Load the miniconda module on the compute node
module load miniconda3-4.8.2-gcc-9.2.0-sbqd2xu
# Activate the conda pytorch environment created in step 1
source activate pytorch
# Launch our test pytorch python file
python testtorch.py
```

### 4. Submit job for execution:
```bash
sbatch testpytorch.sh
```

Output will be '**Submitted batch job XXXXX**'

### 5. Confirm execution results:
Local directory will contain a file '**slurm-XXXXX.out**' which is the output of the job (stdout).

Output should be:
```
cnXXX - <nodename>
<Date>
+--------
| NVIDIA-SMI XXXX...
....
(4 listed V100 GPUs number 0 to 3)

GPU available: True
```

