# Configuring nf-core pipelines

!!! abstract "Objectives"

    - Learn about the structure of an nf-core pipeline.
    - Learn how to customize the execution of an nf-core pipeline.
    - Customize a toy example of an nf-core pipeline.

## Pipeline structure

nf-core pipelines follow a set of best practices and standardised conventions. nf-core pipelines start from a **common template** and follow the same structure. Although you won’t need to edit code in the pipeline project directory, having a basic understanding of the project structure and some core terminology will help you understand how to configure its execution.

Nextflow DSL2 <span style="color:#087f5b;">**workflow**</span> are built up of <span style="color:#364fc7;">**subworkflows**</span> and <span style="color:#c92a2a;">**modules**</span> that are stored as separate `.nf` files.

<br>
<p align="left"><img src="../../images/1_3_structure.excalidraw.png" alt="drawing" width="400"/></p> 
<br>

Most nf-core pipelines consist of a single <span style="color:#087f5b;">**workflow**</span> file (there are a few exceptions). This is the main `<workflow>.nf` file that is used to bring everything else together. Instead of having one large monolithic script, it is broken up into a combination of <span style="color:#364fc7;">**subworkflows**</span> and <span style="color:#c92a2a;">**modules**</span>.

<br>
<p align="center"><img src="../../images/1_3_worksubmod.excalidraw.png" alt="drawing" width="900"/></p> 
<br>

A <span style="color:#364fc7;">**subworkflows**</span> is a groups of modules that are used in combination with each other and have a common purpose. For example, the [`SAMTOOLS_STATS`](https://github.com/nf-core/modules/blob/master/modules/nf-core/samtools/stats/main.nf), [`SAMTOOLS_IDXSTATS`](https://github.com/nf-core/modules/blob/master/modules/nf-core/samtools/faidx/main.nf), and [`SAMTOOLS_FLAGSTAT`](https://github.com/nf-core/modules/blob/master/modules/nf-core/samtools/flagstat/main.nf) modules are all included in the [`BAM_STATS_SAMTOOLS`](https://github.com/nf-core/modules/blob/master/subworkflows/nf-core/bam_stats_samtools/main.nf) subworkflow.

Subworkflows improve pipeline readability and help with the reuse of modules within a pipeline. Within a nf-core pipeline, a subworkflow can be an nf-core subworkflow or as a local subworkflow. Like an nf-core pipeline, an nf-core subworkflow is developed by the community is shared in the [nf-core subworkflows GitHub repository](https://github.com/nf-core/modules/tree/master/subworkflows/nf-core). Local subworkflows are pipeline specific that are not shared in the nf-core subworkflows repository.

A <span style="color:#c92a2a;">**modules**</span> is a wrapper for a process, the basic processing primitive to execute a user script. It can specify [directives](https://www.nextflow.io/docs/latest/process.html#directives), [inputs](https://www.nextflow.io/docs/latest/process.html#inputs), [outputs](https://www.nextflow.io/docs/latest/process.html#outputs), [when statements](https://www.nextflow.io/docs/latest/process.html#when), and a [script](https://www.nextflow.io/docs/latest/process.html#script) block.

Most modules will execute a single tool in the script block and will make use of the directives, inputs, outputs, and when statements dynamically. Like subworkflows, modules can also be developed and shared in the [nf-core modules GitHub repository](https://github.com/nf-core/modules/tree/master/modules/nf-core) or stored as a local module. All modules from the nf-core repository are version controlled and tested to ensure reproducibility. Local modules are pipeline specific that are not shared in the nf-core modules repository.

## Configuration

Each nf-core pipeline comes with a set of “sensible defaults”. While the defaults are a great place to start, you will almost certainly want to modify these to fit your own purposes and system requirements.

**You do not need to edit the pipeline code to configure nf-core pipelines.**

When a pipeline is launched, Nextflow will look for configuration files in several locations. As each source can contain conflicting settings, the sources are ranked to decide which settings to apply. Configuration sources are reported below and listed in order of priority:

1. Parameters specified on the command line (`--parameter`)
2. Parameters that are provided using the `-params-file` option
3. Config file that are provided using the `-c` option
4. The config file named `nextflow.config` in the current directory
5. The config file named `nextflow.config` in the pipeline project directory
6. The config file `$HOME/.nextflow/config`
7. Values defined within the pipeline script itself (e.g., `main.nf`)

!!! warning

    nf-core pipeline parameters must be passed via the command line (`--<parameter>`) or Nextflow `-params-file` option. Custom config files, including those provided by the `-c` option, can be used to provide any configuration **except** for parameters.

Notably, while some of these files are already included in the nf-core pipeline repository (e.g., the `nextflow.config` file in the nf-core pipeline repository), some are automatically identified on your local system (e.g., the `nextflow.config` in the launch directory), and others are only included if they are specified using `run` options (e.g., `-params-file`, and `-c`).

Understanding how and when these files are interpreted by Nextflow is critical for the accurate configuration of a pipelines execution.

### Parameters

**Parameters** are pipeline specific settings that can be used to customise the execution of a pipeline. 

Every nf-core pipeline has a full list of parameters on the nf-core website. When viewing these parameters online, you will also be shown a description and the type of the parameter. Some parameters will have additional text to help you understand when and how a parameter should be used.

Parameters and their descriptions can also be viewed in the command line using the `run` command with the `--help` parameter:

```bash
nextflow run nf-core/<workflow> --help
```

!!! question "Exercise" 

    View the parameters for the `christopher-hakkaart/nf-core-demo` pipeline using the command line:

    ??? success "Solution"

        The `christopher-hakkaart/nf-core-demo` pipeline parameters can be printed using the `run` command and the `--help` option:

        ```bash
        nextflow run christopher-hakkaart/nf-core-demo -r main --help
        ```

### Parameters in the command line

At the highest level, parameters can be customised using the command line. Any parameter can be configured on the command line by prefixing the parameter name with a double dash (`--`):

```bash
nextflow nf-core/<workflow> --<parameter>
```

!!! tip "When to use `--` and `-`"

    Nextflow options are prefixed with a single dash (`-`) and pipeline parameters are prefixed with a double dash (`--`).

Depending on the parameter type, you may be required to add additional information after your parameter flag. For example, for a string parameter, you would add the string after the parameter flag:

```bash
nextflow nf-core/<workflow> --<parameter> string
```

!!! question "Exercise" 

    Give the MultiQC report for the `christopher-hakkaart/nf-core-demo` pipeline the name of your **favorite animal** using the [`multiqc_title`](https://github.com/christopher-hakkaart/nf-core-demo/blob/master/nextflow.config#L27) parameter using a command line flag:

    ??? success "Solution"

        Add the `--multiqc_title` flag to your command and execute it. Use the `-resume` option to save time:

        ```bash
        nextflow run christopher-hakkaart/nf-core-demo --multiqc_title kiwi -resume
        ```

        In this example, you can check your parameter has been applied by listing the files created in the results folder (`my_results`):

        ```bash
        ls my_results/multiqc/
        ```

        `--multiqc_title` is a parameter that directly impacts a result file. For parameters that are not as obvious, you may need to check your `log` to ensure your changes have been applied. You **should not** rely on the changes to parameters printed to the command line when you execute your run:

        ```bash
        nextflow log
        nextflow log <run name> -f "process,script"
        ```

### Default configuration files

All parameters will have a default setting that is defined using the `nextflow.config` file in the pipeline project directory. By default, most parameters are set to `null` or `false` and are only activated by a profile or configuration file.

There are also several `includeConfig` statements in the `nextflow.config` file that are used to include additional `.config` files from the `conf/` folder. Each additional `.config` file contains categorised configuration information for your pipeline execution, some of which can be optionally included:

- `base.config`
    - Included by the pipeline by default.
    - Generous resource allocations using labels.
    - Does not specify any method for software management and expects software to be available (or specified elsewhere).
- `igenomes.config`
    - Included by the pipeline by default.
    - Default configuration to access reference files stored on [AWS iGenomes](https://ewels.github.io/AWS-iGenomes/).
- `modules.config`
    - Included by the pipeline by default.
    - Module-specific configuration options (both mandatory and optional).
- `test.config`
    - Only included if specified as a profile.
    - A configuration profile to test the pipeline with a small test dataset.
- `test_full.config`
    - Only included if specified as a profile.
    - A configuration profile to test the pipeline with a full-size test dataset.

Notably, configuration files can also contain the definition of one or more profiles. A profile is a set of configuration attributes that can be activated when launching a pipeline by using the `-profile` command option:

```bash
nextflow run nf-core/<workflow> -profile <profile>
```

Profiles used by nf-core pipelines include:

- **Software management profiles**
    - Profiles for the management of software using software management tools, e.g., `docker`, `singularity`, and `conda`.
- **Test profiles**
    - Profiles to execute the pipeline with a standardised set of test data and parameters, e.g., `test` and `test_full`.

Multiple profiles can be specified in a comma-separated (`,`) list when you execute your command. The order of profiles is important as they will be read from left to right:

```bash
nextflow run nf-core/<workflow> -profile test,singularity
```

nf-core pipelines are required to define **software containers** and **conda environments** that can be activated using profiles. Although it is possible to run the pipelines with software installed by other methods (e.g., environment modules or manual installation), using Docker or Singularity is more convenient and more reproducible.

!!! tip 

    If you're computer has internet access and one of Conda, Singularity, or Docker installed, you should be able to run any nf-core pipeline with the `test` profile and the respective software management profile 'out of the box'.
    
    The `test` data profile will pull small test files directly from the `nf-core/test-data` GitHub repository and run it on your local system. The `test` profile is an important control to check the pipeline is working as expected and is a great way to trial a pipeline. Some pipelines have multiple test `profiles` for you to try.

### Shared configuration files

An `includeConfig` statement in the `nextflow.config` file is also used to include custom institutional profiles that have been submitted to the nf-core [config repository](https://github.com/nf-core/configs). At run time, nf-core pipelines will fetch these configuration profiles from the [nf-core config repository](https://github.com/nf-core/configs) and make them available.

For shared resources such as an HPC cluster, you may consider developing a shared institutional profile. You can follow [this tutorial](https://nf-co.re/docs/usage/tutorials/step_by_step_institutional_profile) for more help.

### Custom configuration files

Nextflow will also look for files that are external to the pipeline project directory. These files include:

- The config file `$HOME/.nextflow/config`
- A config file named `nextflow.config` in your current directory
- Custom files specified using the command line
    - A parameter file that is provided using the `-params-file` option
    - A config file that are provided using the `-c` option

You don't need to use all of these files to execute your pipeline.

**Parameter files**

Parameter files are `.json` files that can contain an unlimited number of parameters:

```json title="my-params.json"
{
   "<parameter1_name>": 1,
   "<parameter2_name>": "<string>",
   "<parameter3_name>": true
}
```

You can override default parameters by creating a custom `.json` file and passing it as a command-line argument using the `-param-file` option.

```bash
nextflow run nf-core/<workflow> -profile test,singularity -param-file <path/to/params.json> -r main
```

!!! question "Exercise"

    Give the MultiQC report for the `christopher-hakkaart/nf-core-demo` pipeline the name of your **favorite food** using the [`multiqc_title`](https://github.com/christopher-hakkaart/nf-core-demo/blob/master/nextflow.config#L27) parameter in a parameters file:

    ??? success "Solution"

        Create a custom `.json` file that contains your favourite food, e.g., cheese:

        ```json title="my-custom-params.json"
        {
        "multiqc_title": "cheese"
        }
        ```

        Include the custom `.json` file in your execution command with the `-params-file` option:

        ```bash
        nextflow run christopher-hakkaart/nf-core-demo -r main -params-file my_custom_params.json 
        ```

        Check that it has been applied:

        ```bash
        ls my_results/multiqc/
        ```

**Configuration files**

Configuration files are `.config` files that can contain various pipeline properties. Custom paths passed in the command-line using the `-c` option:

```bash
nextflow run nf-core/<workflow> -profile test,singularity -c <path/to/custom.config>
```

Multiple custom `.config` files can be included at execution by separating them with a comma (`,`).

Custom configuration files follow the same structure as the configuration file included in the pipeline directory.

Configuration properties are organised into [scopes](https://www.nextflow.io/docs/latest/config.html#config-scopes) by dot prefixing the property names with a scope identifier or grouping the properties in the same scope using the curly brackets notation. For example:

```console title="custom.config"
alpha.x  = 1
alpha.y  = 'string value'
```

Is equivalent to:

```console title="custom.config"
alpha {
     x = 1
     y = 'string value'
}
```

Scopes allow you to quickly configure settings required to deploy a pipeline on different infrastructure using different software management. For example, the `executor` scope can be used to provide settings for the deployment of a pipeline on a HPC cluster. Similarly, the `singularity` scope controls how Singularity containers are executed by Nextflow.

Multiple scopes can be included in the same `.config` file using a mix of dot prefixes and curly brackets. A full list of scopes is described in detail [here](https://www.nextflow.io/docs/latest/config.html#config-scopes).

!!! question "Exercise"

    Give the MultiQC report for the `christopher-hakkaart/nf-core-demo` pipeline the name of your favorite color using the [`multiqc_title`](https://github.com/christopher-hakkaart/nf-core-demo/blob/master/nextflow.config#L27) parameter in a custom `.config` file:

    ??? success "Solution"

        Create a custom `.config` file that contains your favourite colour, e.g., blue:

        ```bash
        params.multiqc_title = "blue"
        ```

        Include the custom `.config` file in your execution command with the `-c` option:

        ```bash
        nextflow run christopher-hakkaart/nf-core-demo -r main -resume -c custom.config 
        ```

        Check that it has been applied:

        ```bash
        ls my_results/multiqc/
        ```

        **Why did this fail?**

        You **can not** use the `params` scope in custom configuration files. Parameters can only be configured using the `-params-file` option and the command line. While it parameter is listed as a parameter on the `STDOUT`, it **was not** applied to the executed command:

        ```bash
        nextflow log
        nextflow log <run name> -f "process,script"
        ```

The `process` scope allows you to configure pipeline processes and is used extensively to define resources and additional arguments for modules.

By default, process resources are allocated in the `conf/base.config` file using the `withLabel` selector:

```bash title="base.config"
process {
    withLabel: BIG_JOB {
        cpus = 16
        memory = 64.GB
    }
}
```

Similarly, the `withName` selector enables the configuration of a process by name. By default, module parameters are defined in the `conf/modules.config` file:

```bash title="modules.config"
process {
    withName: MYPROCESS {
        cpus = 4
        memory = 8.GB
    }
}
```

While some tool arguments are included as a part of a module. To make modules sharable across pipelines, most tool arguments are defined in the `conf/modules.conf` file in the pipeline code under the `ext.args` entry.

Importantly, having these arguments outside of the module also allows them to be customised at runtime.

<br>
<p align="left"><img src="../../images/1_3_args.excalidraw.png" alt="drawing" width="900"/></p> 
<br>

For example, if you were trying to add arguments in the `MULTIQC` process in the `christopher-hakkaart/nf-core-demo` pipeline, you could use the process scope:

```console title="custom.config"
process {
    withName : ".*:MULTIQC" {
        ext.args   = { "<your custom parameter>" }

    }
```

However, if a process is used multiple times in the same pipeline, an extended execution path of the module may be required to make it more specific:

```console title="custom.config"
process {
    withName: "NFCORE_DEMO:DEMO:MULTIQC" {
        ext.args = "<your custom parameter>"
    }
}
```

The extended execution path is built from the pipelines, subworkflows, and module used to execute the process.

In the example above, the nf-core [`MULTIQC`](https://github.com/christopher-hakkaart/nf-core-demo/blob/master/modules/nf-core/multiqc/main.nf) module, was called by the [`DEMO`](https://github.com/christopher-hakkaart/nf-core-demo/blob/master/workflows/demo.nf) pipeline, which was called by the [`NFCORE_DEMO`](https://github.com/christopher-hakkaart/nf-core-demo/blob/master/main.nf) pipeline in the `main.nf` file.

!!! tip "How to build an extended execution path"

    It can be tricky to evaluate the path used to execute a module. If you are unsure of how to build the path you can copy it from the `conf/modules.conf` file. How arguments are added to a process can also vary. Be vigilant.

!!! question "Exercise" 

    Create a new `.config` file that uses the `process` scope to overwrite the `args` for the `MULTIQC` process. Change the `args` to your favourite **month** of the year, e.g, `"--title \"october\""`.

    ??? success "Solution"

        Make a custom config file that uses the `process` scope to replace the `args` for the `MULTIQC` process:

        ```console title="custom.config"
        process {
            withName: "NFCORE_DEMO:DEMO:MULTIQC" {
                ext.args = "--title \"october\""
            }
        }
        ```

        Execute your run command again with the custom configuration file:

        ```bash
        nextflow run christopher-hakkaart/nf-core-demo -r main -resume -c custom.config
        ```

        Check that it has been applied:

        ```bash
        ls my_results/multiqc/
        ```

!!! question "Exercise" 

    Demonstrate the configuration hierarchy using the `christopher-hakkaart/nf-core-demo` pipeline by adding a params file (`-params-file`), and a command line flag (`--multiqc_title`) to your execution. You can use the files you have already created.

    ??? success "Solution"

        Use the `.json` file you created previously:

        ```json title="my-custom-params.json"
        {
        "multiqc_title": "cheese"
        }
        ```

        Execute your command with your params file (`-params-file`) and a command line flag (`--multiqc_title`):

        ```bash
        nextflow run christopher-hakkaart/nf-core-demo -r main -resume -params-file my_custom_params.json --multiqc_title "kiwi"
        ```

        In this example, as the command line is at the top of the hierarchy, the `multiqc_title` will be "kiwi".

!!! abstract "Key points"

    - nf-core pipelines follow a similar structure.
    - nf-core pipelines are configured using multiple configuration sources.
    - Configuration sources are ranked to decide which settings to apply.
    - Pipeline parameters must be passed via the command line (`--<parameter>`) or Nextflow `-params-file` option.
