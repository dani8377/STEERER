#!/bin/sh
# ${GPUS:-4}
# set -x

#BSUB -J Blurred_QNRF
#BSUB -q hpc
#BSUB -gpu "num=4:mode=exclusive_process"
#BSUB -n 16
#BSUB -R "span[ptile=4]"
#BSUB -M 10GB
#BSUB -W 300:00
#BSUB -o %J.out
#BSUB -e %J.err
#BSUB -u s205336@dtu.dk

#CONFIG=$1
CONFIG="configs/Blurred_QNRF_final.py"
GPUS_ID=${2:-0}    #the default gpu_id is 0 
PORT=${3:-29000}   #the default port is 29000
NNODES=${NNODES:-1}
NODE_RANK=${NODE_RANK:-0}

MASTER_ADDR=${MASTER_ADDR:-"127.0.0.1"}

GPU_NUM=0

for ((i=0; i<${#GPUS_ID}; i++)); do
    if [[ ${GPUS_ID:i:1} =~ [0-9] ]]; then
        ((GPU_NUM++))
    fi
done

source ~/miniconda3/bin/activate STEERER

echo "export CUDA_VISIBLE_DEVICES=$GPUS_ID"
export CUDA_VISIBLE_DEVICES=${GPUS_ID:-"0"}

# Clear GPU cache before starting the training
python3 -c "import torch; torch.cuda.empty_cache()"

# Run the PyTorch distributed training
python3 -m torch.distributed.launch \
    --node_rank=$NODE_RANK \
    --master_addr=$MASTER_ADDR \
    --nproc_per_node=$GPU_NUM \
    --master_port=$PORT \
    tools/train_cc.py --cfg=$CONFIG --launcher="pytorch"
