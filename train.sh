#!/usr/bin/env sh
# Assuming defaults for GPU and port settings

CONFIG=$1
GPUS_ID=${2:-0}    # Default GPU ID is 0 
PORT=${3:-29000}   # Default port is 29000
NNODES=${NNODES:-1}
NODE_RANK=${NODE_RANK:-0}
MASTER_ADDR=${MASTER_ADDR:-"127.0.0.1"}

# Activate your Python environment
source ~/miniconda3/bin/activate STEERER

echo "Setting CUDA_VISIBLE_DEVICES to $GPUS_ID"
export CUDA_VISIBLE_DEVICES=${GPUS_ID:-"0"}

# Calculate number of GPUs being used
GPU_NUM=0
for ((i=0; i<${#GPUS_ID}; i++)); do
    if [[ ${GPUS_ID:i:1} =~ [0-9] ]]; then
        ((GPU_NUM++))
    fi
done

# Run your Python training script with torchrun or using the PyTorch distributed launch utility
python -m torch.distributed.launch \
    --node_rank=$NODE_RANK \
    --master_addr=$MASTER_ADDR \
    --nproc_per_node=$GPU_NUM \
    --master_port=$PORT \
    tools/train_cc.py --cfg=$CONFIG --launcher="pytorch"
