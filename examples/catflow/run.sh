#!/bin/bash

set -e

#pip install "ai2-kit==0.23.6" "oh-my-batch==0.4.7" catflow

# stage1: metadyanmics
./02-workflow/setup.sh

ITER_NAME="000" ./02-workflow/iter-basic-dp-lammps-cp2k.sh
ITER_NAME="001" ./02-workflow/iter-basic-dp-lammps-cp2k.sh
ITER_NAME="002" ./02-workflow/iter-basic-dp-lammps-cp2k.sh

# stage2: constrained MD
./02-workflow/convert.sh

ITER_NAME="003" ./02-workflow/catflow-tesla.sh
ITER_NAME="004" ./02-workflow/catflow-tesla.sh
ITER_NAME="005" ./02-workflow/catflow-tesla.sh
