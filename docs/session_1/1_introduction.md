# Introduction to Nextflow management systems

Workflow Management Systems (WfMS), such as Snakemake, Galaxy, and Nextflow have been developed specifically to manage computational data-analysis workflows in fields such as Bioinformatics, Imaging, Physics, and Chemistry.

WfMS contains multiple features that simplify the development, monitoring, execution, and sharing of pipelines.

Key features include;

!!! quote ""
    
    - **Run time management:** Management of program execution on the operating system and splitting tasks and data to run at the same time in a process called parallelisation.
    - **Software management:** Use of technology like containers, such as Docker or Singularity, that packages up code and all its dependencies so the application runs reliably from one computing environment to another.
    - **Portability & Interoperability:** Workflows written on one system can be run on another computing infrastructure e.g., local computer, compute cluster, or cloud infrastructure.
    - **Reproducibility:** The use of software management systems and a pipeline specification means that the workflow will produce the same results when re-run, including on different computing platforms.
    - **Reentrancy:** Continuous checkpoints allow workflows to resume from the last successfully executed steps.
    

## Nextflow core features

!!! quote-right "" 

    - **Fast prototyping:** A simple syntax for writing pipelines that enables you to reuse existing scripts and tools for fast prototyping.
    
    - **Reproducibility:** Nextflow supports several container technologies, such as Docker and Singularity, as well as the package manager Conda. This, along with the integration of the GitHub code-sharing platform, allows you to write self-contained pipelines, manage versions, and reproduce any former configuration.
    
    - **Portability:** Nextflow’s syntax separates the functional logic (the steps of the workflow) from the execution settings (how the workflow is executed). This allows the pipeline to be run on multiple platforms, e.g. local compute vs. a university compute cluster or a cloud service like AWS, without changing the steps of the workflow.
    
    - **Simple parallelism:** Nextflow is based on the dataflow programming model which greatly simplifies the splitting of tasks that can be run at the same time (parallelisation).
    
    - **Continuous checkpoints:** All the intermediate results produced during the pipeline execution are automatically tracked. This allows you to resume its execution from the last successfully executed step, no matter what the reason was for it stopping.

