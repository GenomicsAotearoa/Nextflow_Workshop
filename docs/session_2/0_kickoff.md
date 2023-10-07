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

!!! terminal-2 "If your previous session has ended you may need to load the required modules and activate the nf-core conda environment again by running the following `source` command"

    ```bash
    source /nesi/project/nesi02659/nextflow-workshop/init-nf-day2
    ```


## Create a new work directory

Create a new directory for all session 2 activities and move into it: 

```default
mkdir ~/session2 && cd $_
```
