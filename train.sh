#!/bin/bash
#BSUB -J virkahelst
#BSUB -o output.%J
#BSUB -e error.%J
#BSUB -n 4
#BSUB -R "rusage[mem=20GB]"
#BSUB -R "span[ptile=4]"
#BSUB -gpu "num=4:mode=exclusive_process"

# Load necessary modules and activate environment if needed
# module load cuda/your_cuda_version
# source activate your_environment

# Set CUDA_VISIBLE_DEVICES to the specified GPUs
GPUS_ID="0,1,2,3"
echo "Setting CUDA_VISIBLE_DEVICES to $GPUS_ID"
export CUDA_VISIBLE_DEVICES=$GPUS_ID

# Launch the training using bsub
bsub -M 20GB python -m torch.distributed.launch \
    --nproc_per_node=4 \
    --node_rank=0 \
    --master_addr="127.0.0.1" \
    --master_port=29000 \
    tools/train_cc.py --cfg=configs/SHHB_final.py --launcher="pytorch"
