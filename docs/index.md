<center>
# Reproducible Bioinformatics Workflows with Nextflow and nf-core
</center>

<br>
<p align="center"><img src="./images/nextflow_logo.png" alt="drawing" width="500"/></p> 
<br>


[Nextflow](https://www.nextflow.io/) is workflow management software which enables the writing of scalable and reproducible scientific workflows. It can integrate various software package and environment management systems from environment modules to Docker, Singularity, and Conda. It allows for existing pipelines written in common scripting languages, such as R and Python, to be seamlessly coupled together. It implements a Domain Specific Language (DSL) that simplifies the implementation and running of workflows on cloud or high-performance computing (HPC) infrastructures.

This lesson also introduces [nf-core](https://nf-co.re/): a community-driven platform, which provide peer reviewed best practice analysis pipelines written in Nextflow and [nf-tower](https://cloud.tower.nf/)(centralized command post for the management of Nextflow data pipelines.)

!!! info circle-info "Nextflow features"

    - **Fast protyping** – let’s you write a computational pipeline from smaller tasks
    - **Reproducibility** – supports Docker and Singularity containers
    - **Portable** – can run locally, Slurm, SGE, PBS, and cloud (Google, Kubernetes and AWS)
    - **Unified parallelism** – can process chunks through the entire pipeline (QC -> align -> call snps)
    - **Continuous checkpoints** – each chunk and process it goes through is checkpointed
    - **Stream oriented** – promotes programming approach extending Unix pipes model.