#!/usr/bin/env bash

# set -x
PARTITION=$1
JOB_NAME=$2
CONFIG=$3
GPUS=$4

GPUS=${GPUS}
GPUS_PER_NODE=${GPUS}
CPUS_PER_TASK=${CPUS_PER_TASK:-5}

PY_ARGS=${@:5}

PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \

source /zhome/bb/4/167805/miniconda3/bin/activate STEERER


srun -p ${PARTITION} \
    --job-name=${JOB_NAME} \
    --gres=gpu:${GPUS_PER_NODE} \
    --ntasks=${GPUS} \
    --ntasks-per-node=${GPUS_PER_NODE} \
    --cpus-per-task=${CPUS_PER_TASK} \
    --quotatype=reserved \
    --kill-on-bad-exit=1 \
    --time=18800 \
    --output=${JOB_NAME}_%J.out \
    -R "rusage[mem=4096]" \
    --preempt \
    ${SRUN_ARGS} \
    python -u tools/train_cc.py --cfg ${CONFIG} --launcher="slurm" ${PY_ARGS}
