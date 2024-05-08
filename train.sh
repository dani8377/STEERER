#!/bin/sh
#BSUB -J Blurred_QNRF                # Set the job name
#BSUB -q gpuv100                      # Specify the queue/partition
#BSUB -gpu "num=4:mode=exclusive_process"  # Request 4 GPUs, exclusive access
#BSUB -n 16                           # Total number of tasks (4 GPUs * 4 cores per GPU = 16 cores)
#BSUB -R "span[ptile=4]"              # Number of cores per node (4 cores per GPU)
#BSUB -M 5GB                          # Memory limit per task
#BSUB -W 24:00                        # Wall clock limit (24 hours)
#BSUB -o %J.out                       # Standard output
#BSUB -e %J.err                       # Standard error

# Activate environment (if needed)
source ~/miniconda3/bin/activate STEERER

# Run the program
sh train.sh configs/Blurred_SHHB_final.py 0,1,2,3
