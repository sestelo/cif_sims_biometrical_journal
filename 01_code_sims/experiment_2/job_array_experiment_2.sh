#!/bin/sh

#SBATCH -J cif_scenario2#job name
#SBATCH -o cif_scenario2-%A-%a.out #specify stdout output file (%A expands to array jobID, %a expands to array task id)
#SBATCH -a 1-6
#SBATCH -p shared --qos shared #Job arrays recommended partition
#SBATCH -n 5 # number of tasks (numero de procesadores)
#SBATCH -N 1 # solicita 1 nodo
#SBATCH -t 30:00:00 # execution time. Ex:hh:mm:ss
#SBATCH --mail-type=begin #Send mail when work starts
#SBATCH --mail-type=end #Send mail when work finishes
#SBATCH --mail-user=sestelo@uvigo.es #E-mail


#-----------------------------------------------------
# A method for determining groups in 
# cumulative incidence curves in competing risk data
#
# Job Array for Experiment 2
# Author: Marta Sestelo
#------------------------------------------------------

# load any necessary module
module load gcc/6.4.0 R/4.0.2


# run the task
#./task.sh 


if [ $SLURM_ARRAY_TASK_ID == 1 ]; then
	Rscript sim_experiment_2.R 500 33 kmedians
elif [ $SLURM_ARRAY_TASK_ID == 2 ]; then
	Rscript sim_experiment_2.R 1000 33 kmedians
elif [ $SLURM_ARRAY_TASK_ID == 3 ]; then
	Rscript sim_experiment_2.R 1500 33 kmedians
elif [ $SLURM_ARRAY_TASK_ID == 4 ]; then
	Rscript sim_experiment_2.R 500 16 kmedians
elif [ $SLURM_ARRAY_TASK_ID == 5 ]; then
	Rscript sim_experiment_2.R 1000 16 kmedians
elif [ $SLURM_ARRAY_TASK_ID == 6 ]; then
	Rscript sim_experiment_2.R 1500 16 kmedians
fi
