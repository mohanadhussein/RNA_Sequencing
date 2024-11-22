#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:010:00
#SBATCH --partition=pibu_el8
#SBATCH --job-name=preanalysis
#SBATCH --mail-user=mohanad.hussein@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=log/preanalysis_%j.out
#SBATCH --error=log/preanalysis_%j.err

# defining variables
WORKDIR="/data/users/mhussein/RNAsequencing/1_fastqc"
OUTPUT_DIR="/data/users/mhussein/RNAsequencing/1_fastqc/fastqc_results"
DATASET="/data/courses/rnaseq_course/toxoplasma_de/reads"
FASTQ_READS="/data/users/mhussein/RNAsequencing/FASTQ_READS"

# creating symbolic links of the original data in the project working directory
for file in "$DATASET"/*.fastq.gz; do
    NAME=$(basename "$file")
    ln -s "$file" "$FASTQ_READS/$NAME"
done

# creating a list with sample names and paths for SLURM jobs
READSDIR="/data/courses/rnaseq_course/toxoplasma_de/reads"
OUTFILE="/data/users/mhussein/RNAsequencing/sample_names.txt"
for FILE1 in "$READSDIR"/*_1.fastq.gz; do
    SAMPLE=$(basename "$FILE1" | sed 's/_1.fastq.gz//')
    FILE2="$READSDIR/${SAMPLE}_2.fastq.gz"
    echo -e "${SAMPLE}\t${FILE1}\t${FILE2}" >> "$OUTFILE"
done
