# Reporting and reproducibility

!!! abstract "Objectives"

    - Understand...



!!! abstract "Key points"

    - Sarek


## Metrics and reports

The nextflow `log` command shows information about executed pipelines in the current folder:

```console
TIMESTAMP               DURATION        RUN NAME                STATUS  REVISION ID     SESSION ID                              COMMAND                                                                  
2023-09-25 07:37:03     -               stupefied_snyder        -       ed1cc84993      5e5497bc-4f66-4f84-b116-dd1a7b9c2d79    nextflow run nf-core/sarek --input samplesheet.csv -params-file my-params.json -profile singularity -r 3.2.3 --tools "freebayes,strelka" -resume                 
2023-09-25 07:37:26     4m 2s           cheeky_lichterman       OK      ed1cc84993      07fe8807-b75e-4487-ad25-e5f88183ef74    nextflow run nf-core/sarek --input samplesheet.csv -params-file my-params.json -profile singularity -r 3.2.3
2023-09-25 08:25:57     1m 38s          kickass_swartz          OK      ed1cc84993      7d49fcd4-1192-48fd-a3a4-4b5801bc3fd7    nextflow run nf-core/sarek -profile test,docker -r 3.2.3 --outdir results_1 
```

Nextflow can produce multiple reports and charts that show several runtime metrics and your execution information.

You can enable this functionality by adding Nextflow options to your run command:

- Adding `-with-report` to your run command will create a HTML execution report which includes many useful metrics about a pipeline execution. 
- Adding `-with-trace` option to creates an execution tracing file that contains some useful information about each process executed in your pipeline script.
- Adding `-with-timeline` to your run command enables the creation of the pipeline timeline report showing how processes were executed over time.
- Adding `-with-dag` to your run command enables the rendering of the pipeline execution direct acyclic graph representation.
    - This feature requires the installation of [Graphviz](https://graphviz.org/) on your computer. Beginning in version 22.04, Nextflow can render the DAG as a Mermaid diagram. Mermaid diagrams are particularly useful because they can be embedded in GitHub Flavored Markdown without having to render them yourself.

!!! note 

    The execution report (`-with-report`), trace report (`-with-trace`), timeline trace (`-with-timeline`), and dag (`-with-dag`) must be specified when the pipeline is executed. By contrast, the `log` option is useful after a pipeline has already run and is available for every executed pipeline.

