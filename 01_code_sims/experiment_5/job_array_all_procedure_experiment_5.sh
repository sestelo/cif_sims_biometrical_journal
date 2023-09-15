#!/bin/sh

#SBATCH -J cif_all_procedure_scenario5_kselect#job name
#SBATCH -o cif_all_procedure_scenario5_kselet-%A-%a.out #specify stdout output file (%A expands to array jobID, %a expands to array task id)
#SBATCH -a 1-12
#SBATCH -n 5 # number of tasks (numero de procesadores)
#SBATCH -N 1 # solicita 1 nodo
#SBATCH -t 48:00:00 # execution time. Ex:hh:mm:ss
#SBATCH --mem-per-cpu=16GB # memory 
#SBATCH --mail-type=begin #Envía un correo cuando el trabajo inicia
#SBATCH --mail-type=end #Envía un correo cuando el trabajo finaliza
#SBATCH --mail-user=sestelom@gmail.com #Dirección a la que se envía


#-----------------------------------------------------
# A method for determining groups in 
# cumulative incidence curves in competing risk data
#
# Job Array for Experiment 5
# Author: Marta Sestelo
#------------------------------------------------------


# load any necessary module

module load cesga/system R/4.2.2


# run the task
#./task.sh 


if [ $SLURM_ARRAY_TASK_ID == 1 ]; then
	Rscript sim_all_procedure_J7_K_4.R 1000 30 kmeans
elif [ $SLURM_ARRAY_TASK_ID == 2 ]; then
	Rscript sim_all_procedure_J7_K_4.R 2500 30 kmeans
elif [ $SLURM_ARRAY_TASK_ID == 3 ]; then
	Rscript sim_all_procedure_J7_K_4.R 5000 30 kmeans
elif [ $SLURM_ARRAY_TASK_ID == 4 ]; then
	Rscript sim_all_procedure_J7_K_4.R 1000 15 kmeans
elif [ $SLURM_ARRAY_TASK_ID == 5 ]; then
	Rscript sim_all_procedure_J7_K_4.R 2500 15 kmeans
elif [ $SLURM_ARRAY_TASK_ID == 6 ]; then
	Rscript sim_all_procedure_J7_K_4.R 5000 15 kmeans

elif [ $SLURM_ARRAY_TASK_ID == 7 ]; then
	Rscript sim_all_procedure_J7_K_4.R 1000 30 kmedians
elif [ $SLURM_ARRAY_TASK_ID == 8 ]; then		
	Rscript sim_all_procedure_J7_K_4.R 2500 30 kmedians
elif [ $SLURM_ARRAY_TASK_ID == 9 ]; then
	Rscript sim_all_procedure_J7_K_4.R 5000 30 kmedians
elif [ $SLURM_ARRAY_TASK_ID == 10 ]; then
	Rscript sim_all_procedure_J7_K_4.R 1000 15 kmedians
elif [ $SLURM_ARRAY_TASK_ID == 11 ]; then
	Rscript sim_all_procedure_J7_K_4.R 2500 15 kmedians
elif [ $SLURM_ARRAY_TASK_ID == 12 ]; then
	Rscript sim_all_procedure_J7_K_4.R 5000 15 kmedians
fi
