# Configuring your deployment

!!! clipboard-list "Objectives"

    - Learn ways to configure your deployment using an executor
    - Learn how to configure resources for your pipeline
    - Learn about nf-core configs

# Choosing your executor

It is likely that you will also want to configure more than just the pipeline tools. Nextflow has many other scopes which allow you to configure the deployment of your pipeline, as well as give you additional control over how it is being executed.

By default your executor will be set to `local`. However, Nextflow supports all of the major HPC and cloud providers and you can quickly and easily change where your pipeline is run using the [`executor`](https://www.nextflow.io/docs/latest/executor.html#executors) scope.

For example, if you would like to use the `slurm` executor. This can be done by adding the following to a config file:

```console title="custom.config"
executor {
    name = 'slurm'
}
```

!!! question "Exercise"

    Try to run the `christopher-hakkaart/nf-core-demo` pipeline using the `-c` flag to specify a custom config file with the code above: 

    ??? success "Solution"

    ```bash
    nextflow run christopher-hakkaart/nf-core-demo -profile test,singularity -r main -c custom.config
    ``` 

    Check your job has been submitted using the `squeue` command:

    ```bash
    squeue --me
    ```

# Configuring your executor

The possibilities for your configuration execution and your executor are endless. As the executor you will need to be mindful of the resources you are requesting and the resources available on your cluster. The many different ways nextflow can configure can be configured to help manage this.

For example, you can also configure the management of your job submissions, e.g., setting the queue size to avoid flooding the cluster:

```console title="custom.config"
executor {
    name = 'slurm'
	queueSize = 4
}
```

Similarly, you might want to control the resources requested by your pipeline. For HPC's, you can't use the `cpu` and `memory` parameters as these are set by the scheduler. Instead, you can use parameters defined by nf-core pipelines to set limits and cause your pipeline to fail before it starts to request resources that are not available on the cluster.

```console title="custom.config"
executor {
    name = 'slurm'
	queueSize = 4
}

params {
  max_memory = 8.GB
  max_cpus = 4
  max_time = 1.h
}
```

If the pipeline is requesting too much, you can modify the resource allocation of specific processes or label using process selectors.

```console title="custom.config"
executor {
    name = 'slurm'
	queueSize = 4
}

params {
  max_memory = 8.GB
  max_cpus = 4
  max_time = 1.h
}

process {
    withName: "NFCORE_DEMO:DEMO:MULTIQC" {
        cpus = 4
    }

    withLabel:process_low {
        cpus   = 2
    }
}
```

## Mixing executors

Another scenario might be that you only want to send specific jobs to your cluster, or a different.

```console title="custom.config"
executor {
    name = 'local'
}

params {
  max_memory = 8.GB
  max_cpus = 4
  max_time = 1.h
}

process {
    withName: "NFCORE_DEMO:DEMO:MULTIQC" {
        executor = 'slurm'
        cpus = 4
    }

    withLabel:process_low {
        cpus   = 2
    }
}
```

The examples above are simple ways you can configure your pipeline to run on your cluster. However, there are many more options available to you. For more information, see the [Nextflow documentation](https://www.nextflow.io/docs/latest/executor.html#executors).

### nf-core/configs

Many nf-core users create an institutional profile and submit it in the [nf-core/configs](https://github.com/nf-core/configs) repository. These profiles can be used by anyone and are a great way to share your customisations with the community.

The [nf-core/configs](https://github.com/nf-core/configs) is loaded by default by nf-core pipelines, meaning that you can apply your customisations by simply adding the `-profile <your_profile>` flag to your run command.

If you are preparing a config for your group or institution, please consider submitting it to [nf-core/configs] to help others in the community.


<br>
!!! cicle-info ""

!!! cboard-list-2 "Key points"

    - Sarek comes with a test profiles that can be used to test the pipeline on your infrastructure
    - Sample sheets are `csv` files that contain important meta data and the paths to your files
    - Reference files are available from iGenomes
    - Parameters go in parameters files and everything else goes in a configuration file
