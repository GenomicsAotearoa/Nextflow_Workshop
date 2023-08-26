# Introduction to Nextflow

!!! abstract "Objectives"

    - Learn about the core features of Nextflow
    - Learn Nextflow terminology
    - Learn fundamental commands and options for executing workflows

## Introduction to workflow management systems

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

## Processes and Channels

In Nextflow, processes and channels are the fundamental building blocks of a workflow.

A **process** is a unit of execution that represents a single computational step in a workflow. It is defined as a block of code that typically performs one specific task. Each process will specify its input and outputs, as well as any directives and conditional statements required for its execution. Processes can be written in any language that can be executed from the command line, such as Bash, Python, Perl, or R.

Processes in are executed independently (i.e., they do not share a common writable state) as **tasks**. Multiple tasks can run in parallel, allowing for efficient utilization of computing resources. Nextflow is a top down workflow manager and will automatically manage data dependencies between processes, ensuring that each process is executed only when its input data is available and all of its dependencies have been satisfied.

A **channel** is an asynchronous first-in, first-out (FIFO) queue that is used to join processes together. Channels allow data to passed between processes and can be used to manage data, parallelize tasks, and structure workflows. Any process can define one or more channels as an input and output. Ultimately the workflow execution flow itself, is implicitly defined by the channel declarations.

Importantly, processes can be **parameterised** to allow for flexibility in their behavior and to enable their reuse in and between workflows. Parameters can be defined in the process declaration and can be passed to the process at runtime. Parameters can be used to specify the input and output files, as well as any other parameters required for the process to execute.

## Execution abstraction

While a process defines what command or script is executed, the **executor** determines how and where the script is executed.

Nextflow provides an **abstraction** between the workflow’s functional logic and the underlying execution system. This abstraction allows users to define a workflow once and execute it on different computing platforms without having to modify the workflow definition.

If not specified, Nextflow will execute locally. Executing locally is useful for workflow development and testing purposes. However, for real-world computational workflows, a high-performance computing (HPC) or cloud platform is often required.

Nextflow provides a variety of built-in execution options, such as local execution, HPC cluster execution, and cloud-based execution, and allows users to easily switch between these options using command-line arguments.

You can find a full list of supported executors as well as how to configure them [here](https://www.nextflow.io/docs/latest/executor.html).

## Nextflow CLI

Nextflow implements a declarative **domain-specific language (DSL)** that simplifies the writing of complex data analysis workflows as an extension of a general-purpose programming language. As a concise DSL, Nextflow handles recurrent use cases while having the flexibility and power to handle corner cases.

Nextflow is an extension of the Groovy programming language which, in turn, is a super-set of the Java programming language. Groovy can be thought of as “Python for Java” and simplifies the code.

Nextflow provides a robust command line interface for the management and execution of workflows. Nextflow can be used on any POSIX compatible system (Linux, OS X, etc). It requires Bash 3.2 (or later) and Java 11 (or later) to be installed.

Nextflow is distributed as a self-installing package and does not require any special installation procedure.

!!! info "How to install Nextflow locally"

    1. Download the executable package using either `wget -qO- https://get.nextflow.io | bash` or `curl -s https://get.nextflow.io | bash`
    2. Make the binary executable on your system by running `chmod +x nextflow`.
    3. Move the nextflow file to a directory accessible by your $PATH variable, e.g, `mv nextflow ~/bin/`

## Nextflow options and commands

Nextflow provides a robust command line interface for the management and execution of workflows. The top-level interface consists of options and commands.

You can list Nextflow options and commands with the `-h` option:

```bash
nextflow -h
```

Options for a commands can also be viewed by appending the -help option to a Nextflow command.

For example, options for the the run command can be viewed:

```bash
nextflow run -help
```

!!! question "Exercise"

    Find out which version of Nextflow you are using.

    ??? success "Solution"
    
        You can find out which version of Nextflow you are using by executing:

        ```bash
        nextflow -version
        ```

## Managing your environment

You can use [environment variables](https://www.nextflow.io/docs/latest/config.html#environment-variables) to control the Nextflow runtime and the underlying Java virtual machine. These variables can be exported before running a workflow and will be interpreted by Nextflow. For most users, Nextflow will work without setting any environment variables. However, to improve reproducibility and to optimise your resources, you will benefit from establishing some environmental variables.

For example, for consistency, it is good practice to pin the version of Nextflow you are using with the `NXF_VER` variable:

```bash
export NXF_VER=<version number>
```

!!! question "Exercise"

    Pin the version of Nextflow to 23.04.1 using the `NXF_VER` environmental variable and check that it has been applied.

    ??? success "Solution"
    
        Export the version using the `NXF_VER` environmental variable:

        ```bash
        export NXF_VER=23.04.1
        ```

        Check that the new version has been applied using the -v option:

        ```bash
        nextflow -v
        ```

Similarly, if you are using a shared resource, you may also consider including paths to where software is stored and can be accessed using the `NXF_SINGULARITY_CACHEDIR` or the `NXF_CONDA_CACHEDIR` variables:

```bash
export NXF_CONDA_CACHEDIR=<custom/path/to/conda/cache>
```

!!! question "Exercise"

    Export the folder **`folder goes here`** as the folder where remote Singularity images are stored:

    ??? success "Solution"
    
        Export the singularity cache using the `NXF_SINGULARITY_CACHEDIR` environmental variable:

        ```bash
        export NXF_SINGULARITY_CACHEDIR=/home/training/singularity_cache
        ```

        Check that the `NXF_SINGULARITY_CACHEDIR` has been exported:

        ```bash
        echo $NXF_SINGULARITY_CACHEDIR
        ```

!!! tip "Tip"
    
        You may want to include these, or other environmental variables, in your `.bashrc` file (or alternate) that is loaded when you log in so you don’t need to export variables every session.

        You may also consider storing these as part of a [Nextflow configuration file](https://www.nextflow.io/docs/latest/config.html#config-files) that can be loaded when you execute a workflow. You will be shown how to do this later in this workshop.

A complete list of environmental variables can be found [here](https://www.nextflow.io/docs/latest/config.html#environment-variables).

## Executing a workflow

Nextflow seamlessly integrates with code repositories such as [GitHub](https://github.com/). This feature allows you to manage your project code and use public Nextflow workflows quickly, consistently, and transparently.

The Nextflow `pull` command will download a workflow from a hosting platform into your global cache `$HOME/.nextflow/assets` folder. 

If you are pulling a project hosted in a remote code repository, you can specify its qualified name or the repository URL.

The qualified name is formed by two parts - the owner name and the repository name separated by a `/` character. For example, if a Nextflow project `bar` is hosted in a GitHub repository `foo` at the address `http://github.com/foo/bar`, it could be pulled using:

```bash
nextflow pull foo/bar
```

Or by using the complete URL:

```bash
nextflow pull http://github.com/foo/bar
```

Alternatively, the Nextflow `clone` command can be used to download a workflow into a local directory of your choice:

```bash
nextflow clone foo/bar <your/path>
```

The Nextflow `run` command is used to initiate the execution of a workflow:

```bash
nextflow run foo/bar
```

If you `run` a workflow, it will look for a local file with the workflow name you’ve specified. If that file does not exist, it will look for a public repository with the same name on GitHub (unless otherwise specified). If it is found, Nextflow will automatically `pull` the workflow to your global cache and execute it.

!!! warning
    
    Be aware of what is already in your current working directory where you launch your workflow, if there are other workflows (or configuration files) you may encounter unexpected results.

!!! question "Exercise"

    Execute the `hello` workflow directly from `nextflow-io` [GitHub](https://github.com/nextflow-io/hello) repository.

    ??? success "Solution"

        Use the `run` command to execute the [nextflow-io/hello](https://github.com/nextflow-io/hello) workflow:

        ```bash
        nextflow run nextflow-io/hello
        ```

        More information about the Nextflow `run` command can be found [here](https://www.nextflow.io/docs/latest/cli.html#run).

## Executing a revision

When a Nextflow workflow is created or updated using GitHub (or another code repository), a new revision is created. Each revision is identified by a unique number, which can be used to track changes made to the workflow and to ensure that the same version of the workflow is used consistently across different runs.

The Nextflow `info` command can be used to view workflow properties, such as the project name, repository, local path, main script, and revisions. The `*` indicates which revision of the workflow you have stickied and will be executed when using the `run` command.

```bash
nextflow info <workflow>
```

It is recommended that you use the revision flag every time you execute a workflow to ensure that the version is correct.

To use a specific revision, you simply need to add it to the command line with the `--revision` or `-r` flag. For example, to run a workflow with the `v1.0` revision, you would use the following:

```bash
nextflow run <workflow> -r v1.0
```

Nextflow automatically provides built-in support for version control using Git. With this, users can easily manage and track changes made to a workflow over time. A revision can be a git `branch`, `tag` or commit `SHA` number, and can be used interchangeably.

!!! question "Exercise"

    Execute the `hello` workflow directly from the `nextflow-io` GitHub using the `v1.1` revision tag.

    ??? success "Solution"

        Use the `nextflow run` command to execute the `nextflow-io/hello` pipeline with the `v1.1` revision tag:

        ```bash
        nextflow run nextflow-io/hello -r v1.1
        ```

        !!! warning "Warning"

            The warning is expected as the `v1.1` workflow revision was written using an older version of Nextflow that uses the depreciated `echo` method. As both Nextflow and workflows are updated independently over time, workflows and Nextflow functions can get out of sync. While most nf-core workflows are now `dsl2` (the current way of writing workflows), some are still written in `dsl1` and may require older version of Nextflow to run.

If your local version of a workflow is not the latest you be shown a warning and will be required to use a revision flag when executing the workflow. You can update a workflow with the Nextflow `pull` command with a revision flag.

## Nextflow log

It is important to keep a record of the commands you have run to generate your results. Nextflow helps with this by creating and storing metadata and logs about the run in hidden files and folders in your current directory (unless otherwise specified). This data can be used by Nextflow to generate reports. It can also be queried using the Nextflow `log` command:

```bash
nextflow log
```

The `log` command has multiple options to facilitate the queries and is especially useful while debugging a workflow and inspecting execution metadata. You can view all of the possible `log` options with `-h` flag:

```bash
nextflow log -h
```

To query a specific execution you can use the `RUN NAME` or a `SESSION ID`:

```bash
nextflow log <run name>
```

To get more information, you can use the `-f` option with named fields. For example:

```bash
nextflow log <run name> -f process,hash,duration
```

There are many other fields you can query. You can view a full list of fields with the `-l` option:

```bash
nextflow log -l
```

!!! question "Exercise"

    Use the `log` command to view with `process`, `hash`, and `script` fields for your tasks from your most recent Nextflow execution.

    ??? success "Solution"

        Use the `log` command to get a list of you recent executions:

        ```bash
        nextflow log
        ```

        Query the process, hash, and script using the `-f` option for the most recent run:

        ```bash
        nextflow log <run_name> -f process,hash,script
        ```

## Execution cache and resume

Task execution **caching** is an essential feature of modern workflow managers. Accordingly, Nextflow provides an automated caching mechanism for every execution.

When using the Nextflow `-resume` option, successfully completed tasks from previous executions are skipped and the previously cached results are used in downstream tasks.

Nextflow caching mechanism works by assigning a unique ID to each task. The task unique ID is generated as a 128-bit hash value composing the the complete file path, file size, and last modified timestamp. These ID's are used to create a separate execution directory where the tasks are executed and the outputs are stored. Nextflow will take care of the inputs and outputs in these folders for you.

A multi-step workflow is required to demonstrate cache and resume. The [`Sydney-Informatics-Hub/nf-core-demo`](https://github.com/Sydney-Informatics-Hub/nf-core-demo/tree/master) workflow was created with the nf-core `create` command and has the same structure as nf-core workflows. It is a toy example with 3 processes:

1. [`SAMPLESHEET_CHECK`](https://github.com/Sydney-Informatics-Hub/nf-core-demo/blob/master/modules/local/samplesheet_check.nf)
   - Executes a custom python script to check the input [sample sheet](https://raw.githubusercontent.com/nf-core/test-datasets/viralrecon/samplesheet/samplesheet_test_illumina_amplicon.csv) is valid.
2. [`FASTQC`](https://github.com/Sydney-Informatics-Hub/nf-core-demo/blob/master/modules/nf-core/fastqc/main.nf)
   - Executes [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) using the `.fastq.gz` files from the [sample sheet](https://raw.githubusercontent.com/nf-core/test-datasets/viralrecon/samplesheet/samplesheet_test_illumina_amplicon.csv) as inputs.
3. [`MULTIQC`](https://github.com/Sydney-Informatics-Hub/nf-core-demo/blob/master/modules/nf-core/multiqc/main.nf)
   - Executes [MultiQC](https://multiqc.info/) using the FastQC reports generated by the `FASTQC` process.

The [`Sydney-Informatics-Hub/nf-core-demo`](https://github.com/Sydney-Informatics-Hub/nf-core-demo/tree/master) is a very small nf-core workflow. It uses real data and bioinformatics software and requires additional configuration to run successfully. To run this example you will need to include two profiles in your execution command. Profiles are sets of configuration options that can be accessed by Nextflow. Profiles will be explained in greater detail during the [Configuring nf-core workflows](1.3_configure.md#1.3.5.-default-configuration-files) section of the workshop.

To run this workflow, both the `test` profile and a software management profile (such as `singularity`) are required:

```bash
nextflow run Sydney-Informatics-Hub/nf-core-demo -profile test,singularity
```

The command line output will print something like this:

Executing this workflow will create a `work` directory and a `my_results` directory with selected results files.

In the schematic above, the hexadecimal numbers, such as `ff/21abfa`, identify the unique task execution. These numbers are also the prefix of the `work` directories where each task is executed.

You can inspect the files produced by a task by looking inside the `work` directory and using these numbers to find the task-specific execution path:

The files that have been selected for publication in the `my_results` folder can also be explored:

```bash
ls my_results
```

If you look inside the `work` directory of a `FASTQC` task, you will find the files that were staged and created when this task was executed:

The `FASTQC` process runs four times, executing in a different work directories for each set of inputs. Therefore, in the previous example, the work directory [1a/3c54ed] represents just one of the four sets of input data that was processed.

To print all the relevant paths to the screen, use the `-ansi-log` option can be used when executing your workflow:

```bash
nextflow run Sydney-Informatics-Hub/nf-core-demo -profile test,singularity -ansi-log false
```

It's very likely you will execute a workflow multiple times as you find the parameters that best suit your data. You can save a lot of spaces (and time) by **resuming** a workflow from the last step that was completed successfully or unmodified.

By adding the `-resume` option to your `run` command you can use the cache rather than re-running successful tasks:

```bash
nextflow run Sydney-Informatics-Hub/nf-core-demo -profile test,singularity -resume
```

If you `run` the Sydney-Informatics-Hub/nf-core-demo workflow again without making any changes you will see that the cache is used:

In practical terms, the workflow is executed from the beginning. However, before launching the execution of a process, Nextflow uses the task unique ID to check if the work directory already exists and that it contains a valid command exit state with the expected output files. If this condition is satisfied, the task execution is skipped and previously computed results are used as the process results.

Notably, the `-resume` functionality is very sensitive. Even touching a file in the work directory can invalidate the cache.

!!! question "Exercise"

    Invalidate the cache by touching a `.fastq.gz` file in a `FASTQC` task work directory (you can use the `touch` command). Execute the workflow again with the `-resume` option to show that the cache has been invalidated.

    ??? success "Solution"

        Execute the workflow for the first time (if you have not already).

        ```bash
        nextflow run Sydney-Informatics-Hub/nf-core-demo -profile test,singularity
        ```

        Use the task ID shown for the `FASTQC` process and use it to find and `touch` a the `sample1_R1.fastq.gz` file:

        ```bash
        touch work/ff/21abfa87cc7cdec037ce4f36807d32/sample1_R1.fastq.gz
        ```

        Execute the workflow again with the `-resume` command option:

        ```bash
        nextflow run Sydney-Informatics-Hub/nf-core-demo -profile test,singularity -resume
        ```

        You should that 2 of 4 tasks for `FASTQC` and the `MULTIQC` task were invalid and were executed again.

        **Why did this happen?**

        In this example, the cache of two `FASTQC` tasks were invalid. The `sample1_R1.fastq.gz` file is used by in the [samplesheet](https://raw.githubusercontent.com/nf-core/test-datasets/viralrecon/samplesheet/samplesheet_test_illumina_amplicon.csv) twice. Thus, touching the symlink for this file and changing the date of last modification disrupted two task executions.

Your work directory can get very big very quickly (especially if you are using full sized datasets). It is good practise to `clean` your work directory regularly. Rather than removing the `work` folder with all of it's contents, the Nextflow `clean` function allows you to selectively remove data associated with specific runs.

```bash
nextflow clean -help
```

The `-after`, `-before`, and `-but` options are all very useful to select specific runs to `clean`. The `-dry-run` option is also very useful to see which files will be removed if you were to `-force` the `clean` command.


!!! question "Exercise"

    You Nextflow to `clean` your work `work` directory of staged files but **keep** your execution logs.

    ??? success "Solution"

        Use the Nextflow `clean` command with the `-k` and `-f` options:

        ```bash
        nextflow clean -k -f
        ```

## Listing and dropping cached workflows

Over time, you might want to remove a stored workflows. Nextflow also has functionality to help you to view and remove workflows that have been pulled locally.

The Nextflow `list` command prints the projects stored in your global cache folder (`$HOME/.nextflow/assets`). These are the workflows that were pulled when you executed either of the Nextflow `pull` or `run` commands:

```bash
nextflow list
```

If you want to remove a workflow from your cache you can remove it using the Nextflow `drop` command:

```bash
nextflow drop <workflow>
```

!!! question "Exercise"

    View your cached workflows with the Nextflow `list` command and remove the `nextflow-io/hello` workflow with the `drop` command.

    ??? success "Solution"

        List your workflow assets:

        ```bash
        nextflow list
        ```

        Drop the `nextflow-io/hello` workflow:

        ```bash
        nextflow drop nextflow-io/hello
        ```

        Check it has been removed:

        ```bash
        nextflow list
        ```

!!! abstract "Key points"

    - Nextflow is a workflow orchestration engine and domain-specific language (DSL) that makes it easy to write data-intensive computational workflows
    - Environment variables can be used to control your Nextflow runtime and the underlying Java virtual machine
    - Nextflow supports version control and has automatic integrations with online code repositories.
    - Nextflow will cache your runs and they can be resumed with the `-resume` option
    - You can manage workflows with Nextflow commands (e.g., `pull`, `clone`, `list`, and `drop`)
