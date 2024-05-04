#!/bin/bash

# Set the job name
#BSUB -J SHHB_Crowd_Train

# Specify the queue/partition
#BSUB -q gpuv100

# Request 4 GPUs, exclusive access
#BSUB -gpu "num=4:mode=exclusive_process"

# Total number of tasks (GPUs in this case)
#BSUB -n 16

# Number of tasks per node
#BSUB -R "span[ptile=4]"

# Memory limit per task
#BSUB -M 20GB

# Wall clock limit (24 hours)
#BSUB -W 24:00

# Standard output
#BSUB -o %J.out

# Standard error
#BSUB -e %J.err

# Activate the Conda environment
source ~/miniconda3/bin/activate STEERER

# Run the Python script
python -u tools/train_cc.py --cfg configs/SHHB_final.py --launcher="lsf" ${@:5}
