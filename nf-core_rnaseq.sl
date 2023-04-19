#!/usr/bin/env bash

#SBATCH --job-name=rnaseq
#SBATCH --output=rnaseq.log
#SBATCH --ntasks-per-node=96
#SBATCH --nodes=1
#SBATCH --time=168:00:00
#SBATCH -p extended-96core

# Run with
# sbatch nf-core_rnaseq.sl

module load openjdk/latest
module load nextflow/latest

export SINGULARITY_CACHEDIR=/gpfs/scratch/$USER/singularity
export NXF_SINGULARITY_CACHEDIR=/gpfs/scratch/$USER/singularity

input_csv=/gpfs/projects/CollierGroup/mariana/genewiz/30-456235246/sample_data_1_rnaseq_auto5.csv
output_dir=/gpfs/projects/restGroup/agilgomez/transcriptomics/rnaseq_test
fasta=/gpfs/projects/CollierGroup/mariana/genewiz/30-456235246/Aurli1/Aurli1_AssemblyScaffolds_Repeatmasked.fasta.gz
gff=/gpfs/projects/CollierGroup/mariana/genewiz/30-456235246/Aurli1/Aurli1_GeneCatalog_genes_20120618.gff 
transcript_fasta_dir=/gpfs/projects/CollierGroup/mariana/genewiz/30-456235246/Aurli1/Aurli1_GeneCatalog_transcripts_20120618.nt.noPID.fasta

nextflow pull nf-core/rnaseq
nextflow run nf-core/rnaseq -profile seawulf,test --input  ${input_csv} --outdir ${output_dir} --fasta  ${fasta} --gff ${gff} --transcript_fasta ${transcript_fasta_dir} 