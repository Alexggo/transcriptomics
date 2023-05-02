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

input_csv=full_samplesheet.csv
output_dir=rna_pipeline1
fasta=Aurli1/Aurli1_AssemblyScaffolds_Repeatmasked.fasta
#gff=Aurli1/Aurli1_all_genes_20120618.gff
gff=Aurli1/Aurli1_2023_ed2.gff

module load openjdk/latest
module load nextflow/latest

nextflow run nf-core/rnaseq \
    -r 3.10.1 \
    --input ${input_csv}  \
    --outdir ${output_dir} \
    --fasta ${fasta} \
    --gff ${gff} \
    -profile seawulf \
    --save_merged_fastq True \
    --save_reference True