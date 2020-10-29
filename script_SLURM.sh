#!/bin/bash
#SBATCH -J corrida1
#SBATCH -p normal
#SBATCH -n 80
#SBATCH -c 1
#SBATCH --ntasks-per-node=8
#SBATCH --mem=15000
#SBATCH -o densidad1_%j.out
#SBATCH -e densidad1_%j.err
#SBATCH --mail-user=fisicafide27@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --exclusive
#

for((k=1; k<=80; k++)); do
./seed$k &
done
wait
