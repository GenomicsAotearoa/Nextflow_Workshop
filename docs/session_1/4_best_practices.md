# Best practices

## Configuration

For reproducibility and clarity, we recommend using the ability to stack Nextflow configurations and use three distinct `.config` files.

- Pipeline-level config: This configuration is system and data agnostic, but should be untouched for any runs of the given pipeline
- System-level config: This configuration is pipeline agnostic but provides settings for running on a given computer system
- Run-level config: This configuration is where changes are made to fine-tune for the specifics of a given run/system/pipeline combination

<!-- TODO: create exercise? kinda covered at the end of the last section -->

## Reporting

Nextflow provides tools that can assist you in making efficient use of resources.

### Execution reports

The most human-readable, but least configurable option is the execution report which is an [HTML execution report](https://docs.seqera.io/nextflow/reports#execution-report) containing CPU and memory utilization information for each individual process as well as each process type. This information can be used to ensure processes are only getting the resources they need.

!!! question "Exercise"

    Download an execution report from one of our nf-core/demo runs and open it in your browser to view it.

    Which process takes the most memory? CPU? Time?

### Execution traces

For a more configurable option, the [trace file](https://docs.seqera.io/nextflow/reports#trace-file) provides many potential fields of interest which can be requested. A full list of fields is available at the previous documentation link, but several of note for optimization and debugging:

- `native_id` will provide the job ID for any jobs submitted to a job scheduler
- `duration` will show the time from submission of the process to completion of the process
- `realtime` will show the time from the start of the process to completion of the process (job run time)
- `%cpu` will show the percentage of CPU used by the process
- `%mem` will sow the percentage of memory used by the process
- `peak_rss` will show the peak of real memory used
- `workdir` will provide the path to the working directory of the process

## Approaches for running Nextflow pipelines on HPCs

Caveat: this is generally true on different HPC systems, but the notes below are tailored for Mahuika.

- Running Nextflow in an interactive Slurm session
  - This method is best for setting up or debugging pipeline executions as the pipeline will end as soon as the interactive session ends.
- Submitting a Nextflow workflow as a batch job
  - This method will run all sub-processes in the same Slurm job. This is best if your workflow would spawn a large number of short jobs.
- Submitting a Nextflow workflow via a head job
  - This method requires submitting a low resource but long running batch job which will control the Nextflow workflow and all processes will be submitted by Nextflow as separate jobs to Slurm. This method is useful for workflows with lots of variation in their computational needs and which comprise mostly long running processes.

<!-- TODO: add demo info? -->
