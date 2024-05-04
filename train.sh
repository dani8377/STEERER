#!/usr/bin/env sh
# Example usage: sh train.sh configs/SHHB_final.py 0,1,2,3

CONFIG=$1
GPUS_ID=${2:-0}  # Default to using GPU 0
PORT=${3:-29000} # Default port
NNODES=${NNODES:-1}
NODE_RANK=${NODE_RANK:-0}
MASTER_ADDR=${MASTER_ADDR:-"127.0.0.1"}

# Splitting GPU IDs on commas, counting them
IFS=',' read -r -a gpu_array <<< "$GPUS_ID"
GPU_NUM=${#gpu_array[@]}

# Activate the Python environment
source ~/miniconda3/bin/activate STEERER

# Set CUDA_VISIBLE_DEVICES to the specified GPUs
echo "Setting CUDA_VISIBLE_DEVICES to $GPUS_ID"
export CUDA_VISIBLE_DEVICES=$GPUS_ID

# Launch the training using the PyTorch distributed framework
bsub -M 20GB python -m torch.distributed.launch \
    --nproc_per_node=$GPU_NUM \
    --node_rank=$NODE_RANK \
    --master_addr=$MASTER_ADDR \
    --master_port=$PORT \
    tools/train_cc.py --cfg=$CONFIG --launcher="pytorch"
