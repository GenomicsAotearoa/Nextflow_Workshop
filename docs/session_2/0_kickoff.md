# Introduction to Session 2

Session 2 builds on fundamental concepts learned in [Session 1](../session_1/0_kickoff.md) and provides you with hands-on experience in nf-core workflow customisation. Throughout the session we will be working with small test data from and the [nf-core/sarek pipeline](https://nf-co.re/sarek/3.2.3). 

We will explore the pipeline source code and apply various customisations using a parameter file and custom configuration files. You will:

* Create custom files for our case study 
* Use the nf-core tools utility
* Run Nextflow commands to query work directories and configuration files 

Each lesson in this session will build on previous lessons. By the end of this session you will have a deeper understanding of the customisation techniques and the impact they have on the workflow execution.

!!! note "Applying what you learn"

    Although activities in this session will use the nf-core/sarek workflow, all customisation scenarios we explore are applicable to other nf-core workflows.

## Log back in into NESI

Follow [set up instructions](../setup/setup.md) to log back into Nesi.



## Create a new work directory

Create a new directory for all session 2 activities and move into it: 

```default
mkdir ~/session2 && cd $_
```
