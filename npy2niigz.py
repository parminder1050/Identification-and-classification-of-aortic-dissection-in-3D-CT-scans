import os
import numpy as np
import nibabel as nib

def construct_affine(spacing, origin):
    """
    Construct an affine matrix from spacing and origin.
    This simple affine assumes the axes are aligned with the world axes.
    :param spacing: Tuple or list of voxel sizes, e.g., (sx, sy, sz)
    :param origin: Tuple or list of origin coordinates, e.g., (ox, oy, oz)
    :return: 4x4 affine matrix
    """
    affine = np.eye(4)
    affine[0, 0] = spacing[0]
    affine[1, 1] = spacing[1]
    affine[2, 2] = spacing[2]
    affine[:3, 3] = origin
    return affine

# Define folders
input_folder = ""  # Provide path to the folder containing .npy files
output_folder = ""  # Provide path to the folder where .nii.gz files will be saved

# Ensure output folder exists
os.makedirs(output_folder, exist_ok=True)

# Process all .npy files in the folder
for filename in os.listdir(input_folder):
    if filename.endswith(".npy"):
        file_path = os.path.join(input_folder, filename)
        loaded = np.load(file_path, allow_pickle=True)
        
        # Check if the file contains a dictionary with metadata
        if isinstance(loaded, dict):
            # Expecting the keys: "data" and optionally "affine" or ("spacing" and "origin")
            ct_scan = loaded.get("data")
            if ct_scan is None:
                print(f"Warning: No 'data' key found in {filename}. Skipping.")
                continue

            if "affine" in loaded:
                affine = loaded["affine"]
            elif "spacing" in loaded and "origin" in loaded:
                spacing = loaded["spacing"]
                origin = loaded["origin"]
                affine = construct_affine(spacing, origin)
            else:
                # Fallback to identity if no affine information is provided.
                print(f"Warning: No affine or (spacing, origin) metadata found in {filename}. Using identity affine.")
                affine = np.eye(4)
        else:
            # If not a dictionary, assume the file is a raw numpy array.
            ct_scan = loaded
            affine = np.eye(4)

        # Remove any singleton dimensions if needed
        ct_scan = np.squeeze(ct_scan)

        # Define new filename (remove "_ct")
        new_filename = filename.replace("_ct", "").replace(".npy", ".nii.gz")
        output_path = os.path.join(output_folder, new_filename)

        # Convert to NIfTI format and save
        nii_img = nib.Nifti1Image(ct_scan, affine)
        nib.save(nii_img, output_path)
        print(f"Converted and saved: {output_path}")

print("Conversion completed!")

