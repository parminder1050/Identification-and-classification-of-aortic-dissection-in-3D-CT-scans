## Identification and classification of aortic dissection in 3D CT scans

This repository contains the code and implementation steps for our work related to identifying and classifying aortic dissection cases in 3D CT scans. We leverage the _nnUNet v2_ model to perform automatic
segmentation of the aorta (four labels) in CT scans. After retrieving the segmentation masks, a simple yet effective procedure has been used for patient-level
classification based on the model’s results (presence of segments and Dice score threshold). 
