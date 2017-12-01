#!/bin/bash
#$ -S /bin/bash
#$ -cwd

module load matlab/R2016a
matlab -nojvm -nodisplay -nodesktop -singleCompThread -r "$1; quit;"