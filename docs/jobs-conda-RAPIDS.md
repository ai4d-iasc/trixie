This examples will show you how to setup and prepare an environment for RAPID jobs using conda on Trixie:

### 1. Create a rapids miniconda environment. Copy and paste the next 3 sections in a terminal. Execute individually

```bash
# ONLY USE IF YOU NEED TO REMOVE THE Python ENV (commented for safety) && \
# ==================================================================== && \
#conda deactivate && \
#conda remove --name rapids --all
```

```bash
# Load Modules and setup Python ENV && \
# ================================= && \
# Some of these modules may not be necessary && \
# You will have to do your own testing if you want a minimal && \
# module selection && \
module purge  && \
module load conda/3-24.9.0 && \
module load python-3.8.3-gcc-9.2.0-qxa3ikk && \
module load cuda-10.1.168-gcc-9.2.0-xyykr4t && \
module load gcc-9.2.0-gcc-9.2.0-vzr5o5q && \
module load autoconf-2.69-gcc-9.2.0-qbibewz && \
module load automake-1.16.2-gcc-9.2.0-6m76nfe && \
conda create -n rapids python=3.8  && \
conda activate rapids
```

```bash
# Install RAPIDS in rapids ENV && \
# ============================ && \
conda install -c rapidsai -c nvidia -c conda-forge \
    -c defaults rapids=0.15 python=3.8 cudatoolkit=10.1
```

### 2. Create a test RAPIDS python script: test_rapids.py

```python
import cudf
import numpy as np

s = cudf.Series([1,2,3,None,4])
print(s)

df = cudf.DataFrame({'a': list(range(20)),
                     'b': list(reversed(range(20))),
                     'c': list(range(20))
                    })
print(df.head(20))


print()
print()

# Simple UDF
def simple_udf(x):
    if x > 0:
        return x + 5
    else:
        return x - 5


# Should run on GPU
print(df['a'].applymap(simple_udf))

print('... done ...')
```

### 3. Create a job submission script: test_rapids.slurm

```bash
#!/bin/bash
# This script was modified for RAPIDS testing purposes...
# Original script : https://github.com/ai4d-iasc/trixie/wiki/Jobs-conda-pytorch
# Specify the partition of the cluster to run on
#SBATCH --partition=JobTesting
# Add your project account code using -A or --account
#SBATCH --account ai4d-bio-04c
# Specify the time allocated to the job. (30 mins just for kicks)
#SBATCH --time=00:30:00
# Request GPUs for the job. In this case 1 GPU
#SBATCH --gres=gpu:1
# Print out the hostname that the jobs is running on
hs=`hostname`
echo -e "host name : $hs"
echo -e "\n"
echo -e "\n"

# Run nvidia-smi to ensure that the job sees the GPUs
/usr/bin/nvidia-smi

echo -e "\n"
echo -e "\n"

# Load the miniconda module on the compute node
module load conda/3-24.9.0
module load python-3.8.3-gcc-9.2.0-qxa3ikk
module load cuda-10.2.89-gcc-9.2.0-fa5atrg
module load gcc-9.2.0-gcc-9.2.0-vzr5o5q
module load autoconf-2.69-gcc-9.2.0-qbibewz
module load automake-1.16.2-gcc-9.2.0-6m76nfe
source activate rapids

# Launch our test python file
python test_rapids.py
```

Output will be '**Submitted batch job XXXXX**'

### 5. Confirm execution results

Local directory will contain a file '**slurm-XXXXX.out**' which is the output of the job (stdout).

Output should be:

```
host name : cn135




Thu Sep 24 17:00:50 2020
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 418.67       Driver Version: 418.67       CUDA Version: 10.1     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  Tesla V100-SXM2...  On   | 00000000:89:00.0 Off |                    0 |
| N/A   31C    P0    42W / 300W |      0MiB / 32480MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+




0       1
1       2
2       3
3    <NA>
4       4
dtype: int64

     a   b   c
0    0  19   0
1    1  18   1
2    2  17   2
3    3  16   3
4    4  15   4
5    5  14   5
6    6  13   6
7    7  12   7
8    8  11   8
9    9  10   9
10  10   9  10
11  11   8  11
12  12   7  12
13  13   6  13
14  14   5  14
15  15   4  15
16  16   3  16
17  17   2  17
18  18   1  18
19  19   0  19


0     -5
1      6
2      7
3      8
4      9
5     10
6     11
7     12
8     13
9     14
10    15
11    16
12    17
13    18
14    19
15    20
16    21
17    22
18    23
19    24
Name: a, dtype: int64
... done ...
```

