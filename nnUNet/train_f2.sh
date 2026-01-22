#!/bin/bash
#SBATCH -N 1
#SBATCH -c 4
#SBATCH --gres=gpu:PR_A6000:1
#SBATCH -p gpu-bigmem
#SBATCH --mem=56G
#SBATCH --qos=long-high-prio
#SBATCH --job-name=pk
#SBATCH -o predict_e100_3dfullres_f2.out
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

#/home3/hghr96/miniconda3/envs/nnUnet/bin/nnUNetv2_plan_and_preprocess -d 501 --verify_dataset_integrity -npfp 2 -np 2

#/home3/hghr96/miniconda3/envs/nnUnet/bin/nnUNetv2_train 501 3d_fullres 'all' --npz

#/home3/hghr96/miniconda3/envs/nnUnet/bin/nnUNetv2_predict -i /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/imagesTs -o /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/Dataset501_AD/3dfullres/imagesTs_prediction_fold2 -d 501 -c 3d_fullres -f 2 -chk checkpoint_best.pth --save_probabilities -device 'cuda' --disable_progress_bar

/home3/hghr96/miniconda3/envs/nnUnet/bin/nnUNetv2_predict -i /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/imagesTs -o /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/Dataset501_AD/3dfullres/imagesTs_prediction_fold2 -d 501 -c 3d_fullres -f 2 -chk checkpoint_best.pth --save_probabilities -device 'cuda' --disable_progress_bar -npp 1 -nps 1


end_time=$(date +%s)
execution_time=$((end_time - start_time))

echo "Finished at $(date)"
echo "Total Execution Time: $execution_time seconds"
