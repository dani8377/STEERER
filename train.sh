#!/bin/bash

#BSUB -J SHHB_Crowd_Train         # Set the job name
#BSUB -q 'gpuv100'               # Specify the queue/partition
#BSUB -gpu "num=4:mode=exclusive_process"  # Request 4 GPUs, exclusive access
#BSUB -n 16                     # Total number of tasks (GPUs in this case)
#BSUB -R "span[ptile=4]"       # Number of tasks per node
#BSUB -M 20GB                  # Memory limit per task
#BSUB -W 24:00                # Wall clock limit (188 hours)
#BSUB -o %J.out                # Standard output
#BSUB -e %J.err                # Standard error

source ~/miniconda3/bin/activate STEERER

# Run the Python script
python -u tools/train_cc.py --cfg configs/SHHB_final.py --launcher="lsf" ${@:5}
