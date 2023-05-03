#!/usr/bin/env bash

#SBATCH --job-name=rnaseq
#SBATCH --output=rnaseq.log
#SBATCH --ntasks-per-node=96
#SBATCH --nodes=1
#SBATCH --time=8:00:00
#SBATCH -p long-96core

# Run with
# sbatch nf-core_rnaseq.sl

export SINGULARITY_CACHEDIR=/gpfs/scratch/$USER/singularity
export NXF_SINGULARITY_CACHEDIR=/gpfs/scratch/$USER/singularity
type=allcont #blocking,exploratory,allcont
input_csv=/gpfs/projects/RestGroup/agilgomez/projects/transcriptomics/samplesheet.csv
output_dir=/gpfs/projects/RestGroup/agilgomez/projects/transcriptomics/rna_diffabn_${type}
gtf=Aurli1/Aurli1_2023_ed2.gtf
contrast=/gpfs/projects/RestGroup/agilgomez/projects/transcriptomics/contrast_${type}.csv
assay=/gpfs/projects/RestGroup/agilgomez/projects/transcriptomics/input_diff_abun/assay_matrix.tsv

module load openjdk/latest
module load nextflow/latest

nextflow run nf-core/differentialabundance \
     --input ${input_csv} \
     --contrasts ${contrast} \
     --matrix ${assay} \
     --gtf ${gtf} \
     --outdir ${output_dir}  \
     -profile seawulf