#!/bin/bash
#SBATCH -N 1
#SBATCH -c 4
#SBATCH --gres=gpu:pascal:1
#SBATCH -p res-gpu-large
#SBATCH --mem=28G
#SBATCH --qos=long-high-prio
#SBATCH --job-name=pk
#SBATCH -o evaluate_e100_3dfullres_f3.out
#SBATCH -t 72:00:00






module load cuda/11.6
source /etc/profile


start_time=$(date +%s)

echo "Starting at $(date)"

#/home3/hghr96/miniconda3/envs/nnUnet/bin/nnUNetv2_plan_and_preprocess -d 501 --verify_dataset_integrity -npfp 2 -np 2

#/home3/hghr96/miniconda3/envs/nnUnet/bin/nnUNetv2_train 501 3d_fullres 0 --npz

#/home3/hghr96/miniconda3/envs/nnUnet/bin/nnUNetv2_predict -i /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/imagesTs -o /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/imagesTs_prediction -d 501 -c 3d_fullres -f 0 -chk checkpoint_best.pth --save_probabilities -device 'cuda' --disable_progress_bar -npp 1 -nps 1

#/home3/hghr96/miniconda3/envs/nnUnet/bin/nnUNetv2_evaluate_folder /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/labelsTs \
# /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/imagesTs_prediction_fold0 \
#-djfile /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/imagesTs_prediction_fold0/dataset.json \
#-pfile /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/imagesTs_prediction_fold0/plans.json

#/home3/hghr96/miniconda3/envs/nnUnet/bin/nnUNetv2_evaluate_folder /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/labelsTs \
# /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/Dataset501_AD/3dlowres/imagesTs_prediction_fold3 \
#-djfile /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/Dataset501_AD/3dlowres/imagesTs_prediction_fold3/dataset.json \
#-pfile /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/Dataset501_AD/3dlowres/imagesTs_prediction_fold3/plans.json

/home3/hghr96/miniconda3/envs/nnUnet/bin/nnUNetv2_evaluate_folder /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/labelsTs \
 /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/Dataset501_AD/3dfullres/imagesTs_prediction_fold3 \
-djfile /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/Dataset501_AD/3dfullres/imagesTs_prediction_fold3/dataset.json \
-pfile /home3/hghr96/parm/work/AD_project/segmentation/nnUNet/testdata_instances_from_data/Dataset501_AD/3dfullres/imagesTs_prediction_fold3/plans.json

end_time=$(date +%s)
execution_time=$((end_time - start_time))

echo "Finished at $(date)"
echo "Total Execution Time: $execution_time seconds"
