import os
import nibabel as nib

# Paths
input_folder = ""  # Provide path to the folder containing .nii files
output_folder = ""  # Provide path to the folder to save .nii.gz files

# Ensure the output directory exists
os.makedirs(output_folder, exist_ok=True)

# Process each .nii file
for filename in os.listdir(input_folder):
    if filename.endswith(".nii"):
        input_path = os.path.join(input_folder, filename)

        # Remove 'nifti' from filename if present
        new_filename = filename.replace("nifti", "").replace(".nii", ".nii.gz")
        output_path = os.path.join(output_folder, new_filename)

        try:
            # Load .nii file
            img = nib.load(input_path)
            
            # Save as .nii.gz
            nib.save(img, output_path)
            print(f"Converted: {filename} -> {new_filename}")
        except Exception as e:
            print(f"Error converting {filename}: {e}")

