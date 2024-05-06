#!/bin/bash
#BSUB -J Blurred_QNRF         # Set the job name
#BSUB -q gpuv100               # Specify the queue/partition
#BSUB -gpu "num=2:mode=exclusive_process"  # Request 2 GPUs, exclusive access
#BSUB -n 2                     # Total number of tasks (GPUs in this case)
#BSUB -M 5GB                  # Memory limit per task
#BSUB -W 24:00                # Wall clock limit (24 hours)
#BSUB -o %J.out                # Standard output
#BSUB -e %J.err                # Standard error

set -x  # Print each command before executing it

# Activate environment (if needed)
source ~/miniconda3/bin/activate STEERER

# Debug: Print some environment information
echo "Job running on $(hostname)"
echo "Current directory: $(pwd)"

# Run the program
python root/STEERER/train.py configs/SHHB_final.py 0,1,2,3
