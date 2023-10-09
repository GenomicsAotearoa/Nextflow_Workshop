# Introduction to nf-core

!!! clipboard-list "Objectives"

    - Learn about the core features of nf-core.
    - Learn how to use nf-core tooling.
    - Use Nextflow to pull the `nf-core/sarek` workflow

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

Upcoming events are listed on the [nf-core event page](https://nf-co.re/events) and announced on [Slack](https://nf-co.re/join/slack) and [Twitter](https://twitter.com/nf_core).

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

Joining multiple nf-core and Nextflow channels is important to keep up to date with the latest community developments and updates. In particular, following the [nf-core](https://twitter.com/nf_core) and [Nextflow](https://twitter.com/nextflowio) Twitter accounts will keep you up-to-date with community announcements. If you are looking for more information about a workflow, the [nf-core YouTube channel](https://www.youtube.com/c/nf-core) regularly shares [ByteSize seminars](https://nf-co.re/events/bytesize/) about best practises, workflows, and community developments.

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

        !!! warning

            Some of these commands may change depending on the operating system you are using.

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

There are currently **88 workflows** (September 2023) available as part of nf-core. These workflows are at various stages of development with 53 released, 23 under development, and 12 archived.

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

!!! question "Exercise"

    Use Nextflow to `pull` the latest version of the `nf-core/sarek` workflow directly from GitHub:

    ??? success "Solution"

        Use Nextlfow to `pull` the `sarek` workflow from the `nf-core` GitHub repository:

        ```bash
        nextflow pull nf-core/sarek -r main
        ```

        Check that it has been pulled by listing your cached pipelines:

        ```bash
        nextflow list
        ```
<br>
!!! circle-info ""

!!! cboard-list-2 "Key points"

    - nf-core is a community effort to collect a curated set of analysis workflows built using Nextflow.
    - You can join/follow nf-core on multiple different social channels (Slack, YouTube, Twitter...)
    - nf-core has its own tooling that can be used by users and developers.
    - Nextflow can be used to `pull` nf-core workflows.
