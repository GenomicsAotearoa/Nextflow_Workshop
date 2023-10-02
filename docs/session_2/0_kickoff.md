# Introduction to Session 2

Session 2 builds on fundamental concepts learned in [Session 1](../session_1/0_kickoff.md) and provides you with hands-on experience in nf-core pipeline customisation.

We will explore the pipeline source code and apply various customisations using a parameter file and custom configuration files. You will:

* Explore the nf-core/sarek source code
* Create custom input files and customise the pipeline execution
* Review the execution of the pipeline with the customisations applied

Each lesson in this session will build on previous lessons. By the end of this session you will have a deeper understanding of the customisation techniques and the impact they have on the pipeline execution.

!!! note "Applying what you learn"

    Although activities in this session will use version 3.2.3 of the [nf-core/sarek](https://nf-co.re/sarek/3.2.3) pipeline, all customisation scenarios we explore are applicable to other nf-core pipelines.

## Log back in into NESI

Follow [set up instructions](../setup/setup.md) to log back into Nesi.

## Load modules and activate the nf-core conda environment

If your previous session has ended you may need to load the required modules and activate the nf-core conda environment again:

```bash
# Purge modules
module purge

# Load modules
module load Miniconda3
source $(conda info --base)/etc/profile.d/conda.sh
module load Singularity/3.11.3
module load Java/17
module load Python/3.10.5-gimkl-2022a
module load Graphviz/2.42.2-GCC-9.2.0

# Add channels
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

# Activate conda
conda activate nf-core

# Export environment variables
export NXF_VER=23.04.0
export NXF_SINGULARITY_CACHEDIR=/nesi/nobackup/nesi02659/nextflow-workshop
```

## Create a new work directory

Create a new directory for all session 2 activities and move into it: 

```default
mkdir ~/session2 && cd $_
```
