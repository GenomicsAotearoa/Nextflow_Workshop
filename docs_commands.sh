#!/usr/bin/env bash
# Commands extracted from docs/session_1/*.md
# Run individually — do not execute this whole file end-to-end.
# Order follows the order in the docs.


# =============================================================================
# 0_kickoff.md — Create a new working directory
# =============================================================================

mkdir ~/training && cd $_


# =============================================================================
# 1_introduction.md — Get started with Nextflow
# =============================================================================

# --- Installing Nextflow (info box; usually NOT needed in the workshop) -------
# Only run if installing Nextflow locally:
wget -qO- https://get.nextflow.io | bash
# or:
curl -s https://get.nextflow.io | bash
chmod +x nextflow
mv nextflow ~/bin/


# --- Nextflow options and commands -------------------------------------------
nextflow -h
nextflow run -help


# --- Exercise: print the version ---------------------------------------------
nextflow -version


# --- Managing your environment -----------------------------------------------
# Exercise: pin the version
export NXF_VER=25.04.4
nextflow -version

# Set version for a single command
NXF_VER=24.10.5 nextflow -version

# Exercise: set apptainer cache dir
export NXF_APPTAINER_CACHEDIR=~/.apptainer_cache
echo $NXF_APPTAINER_CACHEDIR


# --- Executing a pipeline ----------------------------------------------------
# Exercise: run the hello pipeline
nextflow run nextflow-io/hello


# --- Executing a revision ----------------------------------------------------
# Exercise: run hello v1.1 (will fail — DSL1 unsupported)
nextflow run nextflow-io/hello -r v1.1

# Workaround using older Nextflow:
NXF_VER=22.10.0 nextflow run nextflow-io/hello -r v1.1


# --- Nextflow log ------------------------------------------------------------
nextflow log
nextflow log -h
nextflow log -l

# Exercise (replace nice_poitras with your run name):
nextflow log nice_poitras -f process,hash,script


# --- Listing and dropping cached pipelines -----------------------------------
nextflow list

# Exercise:
nextflow drop nextflow-io/hello
nextflow list


# =============================================================================
# 2_nfcore.md — Get started with nf-core
# =============================================================================

# --- nf-core tools -----------------------------------------------------------
nf-core --version
nf-core --help


# --- nf-core demo ------------------------------------------------------------
nextflow run nf-core/demo -profile test,apptainer -r 1.1.0 --outdir results

# Inspect a task work directory (replace prefix with one from your run):
ls work/27/5fa7c0*
ls results
ls work/27/5fa7c0*/

# Run with non-ANSI logging:
nextflow run nf-core/demo -profile test,apptainer -r 1.1.0 --outdir results -ansi-log false

# Resume:
nextflow run nf-core/demo -profile test,apptainer -r 1.1.0 --outdir results -resume


# --- Exercise: invalidate cache ----------------------------------------------
# Replace path with the actual FASTQC task work dir / file from your run:
rm work/b2/87370687cc7cdec037ce4f36807d32/sample1_R1.fastq.gz
nextflow run nf-core/demo -profile test,apptainer -r 1.1.0 --outdir results -resume


# --- Cleaning ----------------------------------------------------------------
nextflow clean -help
nextflow clean -k -f


# =============================================================================
# 3_configuration.md — Configure nf-core pipelines
# =============================================================================

# --- Parameters --------------------------------------------------------------
# Exercise:
nextflow run nf-core/demo -r 1.1.0 --help


# --- Parameters in the command line ------------------------------------------
# Exercise: set MultiQC title via CLI flag
nextflow run nf-core/demo -profile test,apptainer -r 1.1.0 --outdir results --multiqc_title kiwi -resume
ls results/multiqc/

# Verify via log (replace <run name>):
nextflow log
nextflow log <run name> -f "process,script"


# --- Custom configuration files ----------------------------------------------
# Exercise: params file
# First create my-custom-params.json:
#   {
#     "multiqc_title": "cheese"
#   }
nextflow run nf-core/demo -profile test,apptainer -r 1.1.0 --outdir results -params-file my-custom-params.json
ls results/multiqc/


# --- Custom config (-c) ------------------------------------------------------
# Exercise: try (and fail to) override params via -c
# First create custom.config with:
#   params.multiqc_title = "blue"
nextflow run nf-core/demo -profile test,apptainer -r 1.1.0 --outdir results -resume -c custom.config
ls results/multiqc/

# Verify why it didn't apply:
nextflow log
nextflow log <run name> -f "process,script"


# --- Process scope -----------------------------------------------------------
# Exercise: override MULTIQC args
# Create custom.config with:
#   process {
#       withName: "NFCORE_DEMO:DEMO:MULTIQC" {
#           ext.args = "--title \"october\""
#       }
#   }
nextflow run nf-core/demo -r 1.1.0 -profile test,apptainer --outdir results -resume -c custom.config
ls results/multiqc/


# --- Configuration hierarchy -------------------------------------------------
# Exercise: params file + CLI flag (CLI wins)
nextflow run nf-core/demo -r 1.1.0 -profile test,apptainer --outdir results -resume -params-file my-custom-params.json --multiqc_title "cake"


# =============================================================================
# 4_best_practices.md — Best practices
# =============================================================================
# This section is conceptual — no commands to run.