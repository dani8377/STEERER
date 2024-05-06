#!/bin/bash
#BSUB -J Blurred_QNRF          # Set the job name
#BSUB -q gpuv100                # Specify the queue/partition
#BSUB -gpu "num=2:mode=exclusive_process"  # Request 2 GPUs, exclusive access
#BSUB -n 2                      # Total number of tasks (GPUs in this case)
#BSUB -R "rusage[mem=5000]"     # Memory requirement per task
#BSUB -W 24:00                  # Wall clock limit (24 hours)
#BSUB -o %J.out                 # Standard output
#BSUB -e %J.err                 # Standard error

# Activate environment (if needed)
source ~/miniconda3/bin/activate STEERER

# Run the program
python root/STEERER/train_cc.py --config configs/SHHB_final.py --launcher lsf
