# Slurm Fairshare User Manual

## Overview

Fairshare (specifically, Fair-Tree Fairshare) scheduling in Slurm is a mechanism that allows
equitable resource allocation among users and accounts based on their historical resource usage.
This ensures all users receive a fair opportunity to access cluster resources, promoting a balanced
utilization of GPU computational power.

## Key Concepts

### Accounts

- **Accounts:** In Slurm, accounts are used to group users for resource allocation. Each account
can have associated priorities and resource limits. In regards to Beatrix, all NRC users are
equally prioritized for resource allocation.

- **Fairshare Weighting:** Each account is assigned a fairshare factor that influences job
prioritization. The factor is determined based on the account's historical usage and current
resource limits. For more details on the specifics please see
[the slurm fair tree website](https://slurm.schedmd.com/fair_tree.html)

### Partitions

- **Partitions:** These are logical divisions within the cluster, allowing different sets of resources
to be allocated for different types of jobs. Partitions can have different configurations, such as
node types and resource limits.

- Here are the partitions available on the Beatrix cluster
  
    | Partition   | Time limit (D-HH:MM:SS) | Nodes | Note                                                |
    | ----------- | ----------------------- | ----- | --------------------------------------------------- |
    | Trixiemain* | 12:00:00                |  34   | Default partition for all users                     |
    | Trixielong  | 2-00:00:00              |  24   | Users must be authorized by the user representative |
    | JobTesting  | 6:00:00                 |   2   | Job testing partition                               |
    | Preemptible | 12:00:00                |  30   | Jobs submitted here may be pre-empted               |
    | Larus       | 7-00:00:00              |  34   | Industry SME partition, not available to NRC users  |

## Fair-Tree Fairshare Scheduling

### How It Works

- **Historical Usage:** Slurm tracks the historical usage of resources by each account, adjusting
priorities based on this data. Accounts using fewer resources within the fairshare window will have
a higher priority relative to other users who have used more resources. This calculation is done at
multiple levels, such that if accounts A and B are siblings and A has a higher fairshare factor
than B, all children of A will have higher fairshare factors than all children of B.

- **Priority Calculation:** Job priorities are calculated using a combination of fair-share
factors, job age, and other configurable attributes.

- **Dynamic Adjustment:** The system dynamically adjusts priorities, ensuring fair distribution of
resources over time.
