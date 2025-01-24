#!/bin/bash

# this script is to generate deepmd train data and lammps structure files from aimd.xyz
set -e


WORK_DIR=./20-workdir

[ -f $WORK_DIR/setup.done ] && echo "setup already done" && exit 0 || echo "starting setup at $WORK_DIR"

python3 ./01-config/screening/sort_data.py  \
    --n-frames 5 --specorder "[Ag,O]" -a "[14,15]" \
    -t $WORK_DIR/lammps-data-new \
    $WORK_DIR/dp-init-data $WORK_DIR/iter-*/new-dataset/*
        
touch $WORK_DIR/convert.done
