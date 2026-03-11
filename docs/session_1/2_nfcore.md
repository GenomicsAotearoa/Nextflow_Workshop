# Introduction to nf-core

!!! clipboard-list "Objectives"

    - Learn about the core features of nf-core.
    - Learn how to use nf-core tooling.
    - Use Nextflow to pull the `nf-core/demo` workflow

## What is nf-core?

<p align="center"><img src="../../images/1_2_nf-core.png" alt="drawing" width="900"/></p> 

nf-core is a **community** effort to collect a curated set of **analysis workflows** built using Nextflow.

nf-core provides a standardised set of **best practices**, **guidelines**, and **templates** for building and sharing bioinformatics workflows. These workflows are designed to be **modular**, **scalable**, and **portable**, allowing researchers to easily adapt and execute them using their own data and compute resources.

The community is a diverse group of bioinformaticians, developers, and researchers from around the world who collaborate on **developing** and **maintaining** a growing collection of high-quality workflows. These workflows cover a range of applications, including transcriptomics, proteomics, and metagenomics.

One of the key benefits of nf-core is that it promotes **open development**, **testing**, and **peer review**, ensuring that the workflows are robust, well-documented, and validated against real-world datasets. This helps to increase the reliability and reproducibility of bioinformatics analyses and ultimately enables researchers to accelerate their scientific discoveries.

nf-core is published in Nature Biotechnology: [Nat Biotechnol 38, 276–278 (2020). Nature Biotechnology](https://www.nature.com/articles/s41587-020-0439-x)

**Key Features of nf-core workflows**

- **Documentation**
    - nf-core workflows have extensive documentation covering installation, usage, and description of output files to ensure that you won't be left in the dark.
- **CI Testing**
    - Every time a change is made to the workflow code, nf-core workflows use continuous-integration testing to ensure that nothing has broken.
- **Stable Releases**
    - nf-core workflows use GitHub releases to tag stable versions of the code and software, making workflow runs totally reproducible.
- **Packaged software**
    - Pipeline dependencies are automatically downloaded and handled using Docker, Singularity, Conda, or other software management tools. There is no need for any software installations.
- **Portable and reproducible**
    - nf-core workflows follow best practices to ensure maximum portability and reproducibility. The large community makes the workflows exceptionally well-tested and easy to execute.
- **Cloud-ready**
    - nf-core workflows are tested on AWS after every major release. You can even browse results live on the website and use outputs for your own benchmarking.

It is important to remember all nf-core workflows are **open-source** and **community driven**. Pipelines are under active community development and are regularly updated with fixes and other improvements. Even though the pipelines and tools undergo repeated community review and testing - it is important to check your results.

## Events

nf-core events are **community-driven** gatherings that provide a platform to discuss the latest developments in Nextflow and nf-core workflows. These events include community **seminars**, **trainings**, and **hackathons**, and are open to anyone who is interested in using and developing nf-core and its applications. Most events are held virtually, making them accessible to a global audience.

Upcoming events are listed on the [nf-core event page](https://nf-co.re/events) and announced on [Slack](https://nf-co.re/join/slack) and [X (formerly Twitter)](https://twitter.com/nf_core).

## Join the community!

There are several ways you can join the nf-core community. You are welcome to join any or all of these at any time!

<a href="https://nf-co.re/join/slack"><img src="../../images/1_2_slack.png" width="90"/>
<a href="https://github.com/nf-core"><img src="../../images/1_2_github.png" width="90"/>
<a href="https://twitter.com/nf_core"><img src="../../images/1_2_twitter.png" width="100"/> 
<a href="https://mstdn.science/@nf_core"><img src="../../images/1_2_mastodon.png" width="80"/> 
<a href="https://www.youtube.com/c/nf-core"><img src="../../images/1_2_youtube.png" width="120"/>
<a href="https://bsky.app/profile/nf-co.re"><img src="../../images/1_2_bluesky.png" width="90"/>
<a href="https://www.linkedin.com/company/nf-core"><img src="../../images/1_2_linkedin.png" width="90"/>

The nf-core Slack is one of the primary resources for nf-core users. There are dedicated channels for all workflows as well as channels for common topics.

If you are unsure of where to ask you questions - the `#help` and `#nostupidquestions` channels are a great place to start.

!!! tip "Questions about Nextflow"

    If you have questions about Nextflow and deployments that are not related to nf-core you can ask them on the [Nextflow Slack](https://www.nextflow.io/blog/2022/nextflow-is-moving-to-slack.html). It's worthwhile joining both Slack groups and browsing the channels to get an idea of what types of questions are being asked on each channel. Searching channels can also be a great source of information as your question may have been asked before.

Joining multiple nf-core and Nextflow channels is important to keep up to date with the latest community developments and updates. In particular, following the [nf-core](https://twitter.com/nf_core) and [Nextflow](https://twitter.com/nextflowio) accounts on X (formerly Twitter) will keep you up-to-date with community announcements. If you are looking for more information about a workflow, the [nf-core YouTube channel](https://www.youtube.com/c/nf-core) regularly shares [ByteSize seminars](https://nf-co.re/events/bytesize/) about best practises, workflows, and community developments.

!!! question "Exercise"

    Join the [nf-core Slack](https://nf-co.re/join/slack) and fill in your profile information. If you're joining the nf-core Slack for the first time make sure you drop a message in `#say-hello` to introduce yourself! 👋

    ??? success "Solution"

        Follow [this link](https://nf-co.re/join/slack) to join the nf-core Slack. Follow the instructions to enter your credentials and update your profile. Even if you are already a member of the nf-core Slack, it's a great time to check your profile is up-to-date.

## nf-core tools

This workshop will make use of nf-core tools, a set of helper tools for use with Nextflow workflows. These tools have been developed to provide a range of additional functionality for **using**, **developing**, and **testing** workflows.

??? tip "How to download nf-core tools - *Don't have to do this install today as it is already installed to your workshop environment.*"

    nf-core tools is written in Python and is available from the [Python Package Index (PyPI)](https://pypi.org/project/nf-core/):

    ```bash
    pip install nf-core
    ```

    Alternatively, nf-core tools can be installed from [Bioconda](https://anaconda.org/bioconda/nf-core):

    ```bash
    conda install -c bioconda nf-core
    ```

The nf-core `--version` option can be used to print your version of nf-core tools:

```bash
nf-core --version
```

!!! question "Exercise"

    Find out what version of nf-core tools you have available using the nf-core `--version` option. If nf-core tools is not installed then install it using the commands above:

    ??? success "Solution"

        Use the nf-core `--version` option to print your nf-core tools version:

        ```bash
        nf-core --version
        ```

        If you get the message "`nf-core: command not found`" - install nf-core using the commands above:

        Download `nf-core` from the Python Package Index (PyPI):

        ```bash
        pip install nf-core
        ```

        Use the nf-core `--version` option to print your nf-core tools version:

        ```bash
        nf-core --version
        ```

nf-core tools are for everyone and has commands to help both **users** and **developers**.

For users, the tools make it easier to execute workflows.

For developers, the tools make it easier to develop and test your workflows using best practices. You can read about the nf-core commands on the [tools page](https://nf-co.re/tools/) of the nf-core website or using the command line.

!!! question "Exercise"

    Find out what nf-core tools commands and options are available using the `--help` option:

    ??? success "Solution"

        Execute the `--help` option to list the options, commands for users, and commands for developers:

        ```bash
        nf-core --help
        ```

nf-core tools is updated with new features and fixes regularly so it's best to keep your version of nf-core tools up-to-date.

## Executing an nf-core workflow

There are currently **over 100 workflows** available as part of nf-core. These workflows are at various stages of development with many released, under active development, or archived.

The [nf-core website](https://nf-co.re/) has a full list of workflows, as well as their documentation, which can be explored.

Each workflow has a dedicated page that includes expansive documentation that is split into 6 sections:

- **Introduction:** An introduction and overview of the workflow
- **Usage:** Descriptions of how to execute the workflow
- **Parameters:** Grouped workflow parameters with descriptions
- **Output:** Descriptions and examples of the expected output files
- **Results:** Example output files generated from the full test dataset
- **Releases & Statistics:** Workflow version history and statistics

Unless you are actively developing workflow code, you don't need to clone the workflow code from GitHub and can use Nextflow’s built-in functionality to `pull` and a workflow. As shown in the previous lesson, the Nextflow `pull` command can download and cache workflows from [GitHub](https://github.com/nf-core/) repositories:

```bash
nextflow pull nf-core/<pipeline>
```

Nextflow `run` will also automatically `pull` the workflow if it was not already available locally:

```bash
nextflow run nf-core/<pipeline>
```

Nextflow will `pull` the default git branch if a workflow version is not specified. This will be the master branch for nf-core workflows with a stable release. nf-core workflows use GitHub releases to tag stable versions of the code and software. You will always be able to execute a previous version of a workflow once it is released using the `-revision` or `-r` flag.


## nf-core demo

The [`nf-core/demo`](https://github.com/nf-core/demo) is a very small nf-core pipeline. It uses real data and bioinformatics software and requires additional configuration to run successfully.

The [`nf-core/demo`](https://github.com/nf-core/demo) pipeline was created with the nf-core `create` command and has the same structure as nf-core pipelines. It is a toy example with 3 processes:

1. [`FASTQC`](https://github.com/nf-core/demo/blob/main/modules/nf-core/fastqc/main.nf)
    - Executes [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) using the test `.fastq.gz` files as inputs.
2. [`SEQTK_TRIM`](https://github.com/nf-core/demo/blob/main/modules/nf-core/seqtk/trim/main.nf)
    - Trims low-quality bases from FASTQ files using [SeqTK](https://github.com/lh3/seqtk).
3. [`MULTIQC`](https://github.com/nf-core/demo/blob/main/modules/nf-core/multiqc/main.nf)
    - Executes [MultiQC](https://multiqc.info/) using the FastQC reports generated by the `FASTQC` process.

To run this pipeline, both the `test` profile and a software management profile (such as `singularity`) are required:

```bash
nextflow run nf-core/demo -profile test,singularity -r 1.1.0 --outdir results
```

The command line output will print something like this:

```console title="Output"
N E X T F L O W  ~  version 25.10.4
Launching `https://github.com/nf-core/demo` [voluminous_kay] DSL2 - revision: 8f8c2b63c0 [1.1.0]


------------------------------------------------------
                                        ,--./,-.
        ___     __   __   __   ___     /,-._.--~'
  |\ | |__  __ /  ` /  \ |__) |__         }  {
  | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                        `._,._,'
  nf-core/demo v1.1.0
------------------------------------------------------
Core Nextflow options
  revision                  : 1.1.0
  runName                   : voluminous_kay
  containerEngine           : singularity
  launchDir                 : /home/user/session1
  workDir                   : /home/user/session1/work
  projectDir                : /home/user/.nextflow/assets/nf-core/demo
  userName                  : user
  profile                   : test,singularity
  configFiles               : /home/user/.nextflow/assets/nf-core/demo/nextflow.config

Input/output options
  input                     : https://raw.githubusercontent.com/nf-core/test-datasets/fastq/samplesheet.csv
  outdir                    : results

Institutional config options
  config_profile_name       : Test profile
  config_profile_description: Minimal test dataset to check pipeline function

Max job request options
  max_cpus                  : 2
  max_memory                : 6.GB
  max_time                  : 6.h

!! Only displaying parameters that differ from the pipeline defaults !!
------------------------------------------------------
If you use nf-core/demo for your analysis please cite:

* The nf-core framework
  https://doi.org/10.1038/s41587-020-0439-x

* Software dependencies
  https://github.com/nf-core/demo/blob/main/CITATIONS.md
------------------------------------------------------
[bb/f98425] process > NFCORE_DEMO:DEMO:FASTQC (SAMPLE1_PE_T1)    [100%] 4 of 4 ✔
[cc/123456] process > NFCORE_DEMO:DEMO:SEQTK_TRIM (SAMPLE1_PE_T1)[100%] 4 of 4 ✔
[dd/728742] process > NFCORE_DEMO:DEMO:MULTIQC                    [100%] 1 of 1 ✔
-
Completed at: 29-Aug-2025 22:16:49
Duration    : 2m 27s
CPU hours   : (a few seconds)
Succeeded   : 9
```

Executing this pipeline will create a `work` directory and a `results` directory with selected results files.

In the output above, the hexadecimal numbers, such as `bb/f98425`, identify the unique task execution. These numbers are also the prefix of the `work` directories where each task is executed.

You can inspect the files produced by a task by looking inside the `work` directory and using these numbers to find the task-specific execution path:

The files that have been selected for publication in the `results` folder can also be explored:

```bash
ls results
```

If you look inside the `work` directory of a `FASTQC` task, you will find the files that were staged and created when this task was executed:

The `FASTQC` process runs four times, executing in a different work directories for each set of inputs. Therefore, in the previous example, the work directory [bb/f98425] represents just one of the four sets of input data that was processed.

To print all the relevant paths to the screen, use the `-ansi-log` option can be used when executing your pipeline:

```bash
nextflow run nf-core/demo -profile test,singularity -r 1.1.0 --outdir results -ansi-log false
```

It's very likely you will execute a pipeline multiple times as you find the parameters that best suit your data. You can save a lot of spaces (and time) if you **resume** a pipeline from the last step that was completed successfully or unmodified.

By adding the `-resume` option to your `run` command you can use the cache rather than re-running successful tasks:

```bash
nextflow run nf-core/demo -profile test,singularity -r 1.1.0 --outdir results -resume
```

If you `run` the `nf-core/demo` pipeline again without making any changes you will see that the cache is used:

```console title="Output"
[truncated]
[b2/873706] process > NFCORE_DEMO:DEMO:FASTQC (SAMPLE2_PE_T1)    [100%] 4 of 4, cached: 4 ✔
[cc/123456] process > NFCORE_DEMO:DEMO:SEQTK_TRIM (SAMPLE2_PE_T1)[100%] 4 of 4, cached: 4 ✔
[ca/e8e0a8] process > NFCORE_DEMO:DEMO:MULTIQC                    [100%] 1 of 1, cached: 1 ✔
[truncated]
```

In practical terms, the pipeline is executed from the beginning. However, before launching the execution of a process, Nextflow uses the task unique ID to check if the work directory already exists and that it contains a valid command exit state with the expected output files. If this condition is satisfied, the task execution is skipped and previously computed results are used as the process results.

The `-resume` functionality is very sensitive. Even touching a file in the work directory can invalidate the cache.

!!! question "Exercise"

    Invalidate the cache by touching a `.fastq.gz` file in a `FASTQC` task work directory (you can use the `touch` command). Execute the pipeline again with the `-resume` option to show that the cache has been invalidated.

    ??? success "Solution"

        Execute the pipeline for the first time (if you have not already).

        ```bash
        nextflow run nf-core/demo -profile test,singularity -r 1.1.0 --outdir results
        ```

        Use the task ID shown for the `FASTQC` process and use it to find and `touch` a `.fastq.gz` file in that task's work directory:

        ```bash
        touch work/b2/87370687cc7cdec037ce4f36807d32/sample1_R1.fastq.gz
        ```

        Execute the pipeline again with the `-resume` command option:

        ```bash
        nextflow run nf-core/demo -profile test,singularity -r 1.1.0 --outdir results -resume
        ```

        You should see that the affected `FASTQC` task, the corresponding `SEQTK_TRIM` task, and the `MULTIQC` task were invalidated and executed again.

        **Why did this happen?**

        In this example, the cache of the `FASTQC` task was invalidated because the `sample1_R1.fastq.gz` file was modified. Touching the symlink and changing the date of last modification caused Nextflow to re-run the affected task and all downstream tasks that depended on its output.

Your work directory can get very big very quickly (especially if you are using full sized datasets). It is good practise to `clean` your work directory regularly. Rather than removing the `work` folder with all of it's contents, the Nextflow `clean` function allows you to selectively remove data associated with specific runs.

!!! cboard-list-2 "Key points"

    - nf-core is a community effort to collect a curated set of analysis workflows built using Nextflow.
    - You can join/follow nf-core on multiple different social channels (Slack, YouTube, Twitter...)
    - nf-core has its own tooling that can be used by users and developers.
    - nf-core pipelines come wth test data and configuration profiles that help them run out of the box
