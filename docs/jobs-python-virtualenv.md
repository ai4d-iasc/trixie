This examples will show you how to setup and prepare an environment for Python tensoflow jobs using virtualenv on Trixie:

### 1. Create a python virtual environment:
Either run from the command line or create tf-py37-environment.sh and run it:

file: tf-py37-environment.sh:
```bash
#!/bin/bash

## 1.(a) load the CC python3.7 module & required libs:
module load python/3.7
module load cuda/10.0 cudnn
module load hdf5

## -or- 1.(b) choose to load python3.8 instead:
#module load python/3.8
#module load cuda/10.1.243 cudnn
#module load hdf5


## 2. Create a path for venv
mkdir -p ~/work/venv
# or use the project path to share virtualenv:
#mkdir -p ~/project/venv

## 2.2. Confirm python version & paths (to make sure modules loaded ok:
module list
which python
which pip
python --version

## 3.1. Create a new virtual environment named tf-py37:
virtualenv ~/work/venv/tf-py37

## 3.2. activate env:
source ~/work/venv/tf-py37/bin/activate  

## 3.3. run pip to install tf 1.x:
pip install tensorflow-gpu==1.15.0

## See also table: https://stackoverflow.com/questions/50622525/which-tensorflow-and-cuda-version-combinations-are-compatible
# Trixie presently supports cuda versions: 10.0.x and 10.1.x:
#   - TF 1 works with cuda 10.0.130
#   - TF 2 works with cuda 10.1.243
```
NOTE: with virtualenv it is still first necessary (upon login/beginning
of scripts) to ```module load``` for the python version, if it differs from
defaults already loaded (in output of: ```module list```).

### 2. Create a test python virtualenv script

test-tf-py37.py:
```python
import tensorflow as tf
print('Tensorflow version:', tf.__version__())
if tf.test.gpu_device_name():
  print('Default GPU Device: {}'.format(tf.test.gpu_device_name()))
else:
  print("Could not find GPU. Please install GPU version of TF.")
```

### 3. Create a job script

test-tf-py37.sh:
```bash
#!/bin/bash

# Specify the partition of the cluster to run on (Typically TrixieMain)
#SBATCH --partition=TrixieMain
# Add your project account code using -A or --account
#SBATCH --account ai4d
# Specify the time allocated to the job. Max 12 hours on TrixieMain queue.
#SBATCH --time=12:00:00
# Request GPUs for the job. In this case 1 GPU
#SBATCH --gres=gpu:1
# Print out the hostname that the jobs is running on
hostname
# Run nvidia-smi to ensure that the job sees the GPUs
/usr/bin/nvidia-smi

module load python/3.7
module load cuda/10.0 cudnn
module load hdf5

source ~/work/venv/tf-py37/bin/activate  

# Launch our test tensorflow python file
python test-tf-py37.py
```

### 4. Submit job for execution:
Remember to run the job script on a compute node using srun or sbatch
commands in order to first allocate gpu resources.  

```bash
sbatch test-tf-py37.sh

srun --gres=gpu:1 -n 1 --pty /bin/bash --login   
$ test-tf-py37.sh
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

Tensorflow version: 1.15.0
Default GPU Device:  ..
```

