import cv2
import os
import sys
import subprocess

def open_image(image_path):
    if sys.platform == "darwin":  # Since you're using a MacBook
        subprocess.run(["open", image_path])
    elif sys.platform == "win32":
        os.startfile(image_path)
    else:  # Assuming Linux or a similar OS
        subprocess.run(["xdg-open", image_path])

# Instead of getting the paths from command line arguments, prompt the user for input
image_dir = input("Enter the path to the directory with images: ")
output_dir = input("Enter the path to the directory where blurred images will be saved: ")

# Make sure output directory exists
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Get all filenames in the directory
filenames = os.listdir(image_dir)

# Loop through all filenames
for filename in filenames:
    # Check if the file is a supported image format (optional)
    if filename.endswith(".jpg") or filename.endswith(".png"):  # Adjust for supported formats
        # Construct the full path to the image
        image_path = os.path.join(image_dir, filename)
        # Load the image
        img = cv2.imread(image_path)

        # Check if image loading was successful (optional, handle potential errors)
        if img is not None:  # Skip processing if image fails to load
            # Apply Gaussian blur (adjust blur radius as needed)
            blurred_img = cv2.GaussianBlur(img, (5, 5), 0)

            # Create a new filename for the blurred image (optional)
            output_filename = f"blurred_{filename}"

            # Save the blurred image in the output directory
            output_image_path = os.path.join(output_dir, output_filename)
            cv2.imwrite(output_image_path, blurred_img)

            print(f"Image '{filename}' blurred and saved as '{output_filename}'.")

            # Optionally, open the blurred image
            # open_image(output_image_path)