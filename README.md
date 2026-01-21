## Identification and classification of aortic dissection in 3D CT scans

This repository contains the code and implementation steps for our work related to identifying and classifying aortic dissection (AD) cases in 3D CT scans. We leverage the _nnUNet v2_ model to perform automatic segmentation of the aorta (**four labels**) in CT scans. After retrieving the segmentation masks, a simple yet effective procedure was used for patient-level classification (**three classes**) based on the model’s results (segment presence and Dice score threshold). The two types of AD, as per _Stanford criteria_, are **Type A (TBAD) and Type B (TBAD)**. The third class we are considering here is a normal CT scan, dubbed **NoAD**. 

The dataset used for experimentation was collected by retrospectively searching the picture archiving and communication system (PACS) database based at a single regional tertiary vascular and cardiothoracic unit, following national and local ethics approval. Contrast-enhanced CTA scans were included and reviewed by radiologists. The data annotation consists of four labels: **dissected pre, dissected post, non pre, and non post** where _pre_ and _post_ refer to the location of the dissection relative to the subclavian artery, a branch of the aorta acting as a boundary between _TAAD_ and _TBAD_, respectively. A scan containing the label _dissected pre_ is classified as _TAAD_; if it contains _dissected post_ without _dissected pre_, it is classified as _TBAD_, and if it contains _non pre_ and _non post_ labels only, then the scan is classified as _NoAD_.

### Implementation procedure
#### Step 1: Segmenting four aorta labels
We used the nnUNet v2 segmentation model (from the [GitHub link](https://github.com/MIC-DKFZ/nnUNet)) to segment the different sections of the aorta according to the labels. The scans and masks were converted to the .nii.gz format for providing input to the nnUNet
model.


