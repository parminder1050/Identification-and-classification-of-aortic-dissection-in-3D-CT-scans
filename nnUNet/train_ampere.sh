#!/bin/bash
#SBATCH -N 1
#SBATCH -c 4
#SBATCH --gres=gpu:ampere:1
#SBATCH -p gpu-bigmem
#SBATCH --mem=56G
#SBATCH --qos=long-high-prio
#SBATCH --job-name=pk
#SBATCH -o preprocess_ampere.out
#SBATCH -t 72:00:00






module load cuda/11.6
source /etc/profile

### --gres=gpu:1
### -w gpu8


### --qos=long-high-prio

# --gres=gpu:PR_A6000:1
# --reservation=PR_A6000

## --gres=gpu:turing:1
## -p res-gpu-small


start_time=$(date +%s)

echo "Starting at $(date)"

/home3/hghr96/miniconda3/envs/nnUnet/bin/nnUNetv2_plan_and_preprocess -d 501 --verify_dataset_integrity

#/home3/hghr96/miniconda3/envs/nnUnet/bin/nnUNetv2_train 501 3d_fullres 0 --npz

end_time=$(date +%s)
execution_time=$((end_time - start_time))

echo "Finished at $(date)"
echo "Total Execution Time: $execution_time seconds"
