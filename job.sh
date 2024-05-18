#!/bin/sh
#BSUB -J   qnrftrain         # Set the job name
#BSUB -q gpuv100               # Specify the queue/partition
#BSUB -gpu "num=2:mode=exclusive_process"  # Request 4 GPUs, exclusive access
#BSUB -n 8                     # Total number of tasks (GPUs in this case)
#BSUB -M 10GB                  # Memory limit per task
#BSUB -W 24:00                # Wall clock limit (188 hours)
#BSUB -o %J.out                # Standard output
#BSUB -e %J.err                # Standard error

# Activate environment (if needed)
source ~/miniconda3/bin/activate STEERER

# Run the program
sh train.sh configs/QNRF_final.py 0,1