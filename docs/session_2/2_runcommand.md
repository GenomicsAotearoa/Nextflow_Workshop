# Configuring your run

!!! clipboard-list "Objectives"

    - Understand the different parts of a run command
    - Learn how to customise a run command
    - Learn how to use a parameter file and configuration files to customise a run command

## Where to start

A recommended run command can be found for each pipeline on the nf-core website and is a useful starting point for customising a run command:

```bash
nextflow run nf-core/sarek --input samplesheet.csv --genome GATK.GRCh38 -profile docker
```

From here, the command can be customised to suit your needs. The following sections will describe the different components of the command and how they can be customised.

In this example, the same small test data files that are used in the test profile will be used to demonstrate how to create you own sample sheet. However, you will be writing the files rather than relying on the test profile. The same concepts will apply to data on your local storage.

### Input (`--input`)

The Sarek pipeline requires a samplesheet as an input parameter. This is a `csv` file that contains information about the samples that will be processed. The samplesheet is used to specify the location of the input data, the sample name, and additional metadata.

A samplesheet is created manually and can be stored anywhere on your computer. The samplesheet can be named anything you like, but it must be specified using the `--input` flag.

More information about how to structure a samplesheet for Sarek can be found in the [usage documentation](https://nf-co.re/sarek/3.2.3/docs/usage/#input-sample-sheet-configurations).

Note how Sarek can accept different data types as inputs and how the samplesheet is different for each.

!!! question "Exercise"

    Use the [usage documentation](https://nf-co.re/sarek/3.2.3/docs/usage/#input-sample-sheet-configurations) to create `samplesheet.csv` in your working directory. It must include the following data in the required format:

    - **patient:** test
    - **sex:** XX
    - **status:** test
    - **sample:** test_L1
    - **fastq_1:** https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/- genomics/homo_sapiens/illumina/fastq/test_1.fastq.gz
    - **fastq_2:** https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/illumina/fastq/test_2.fastq.gz

    ??? success "Solution"

        Your `csv` file should look like the following:

        ```csv title="samplesheet.csv"
        patient,sex,status,sample,lane,fastq_1,fastq_2
        test,XX,0,test,test_L1,https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/illumina/fastq/test_1.fastq.gz,https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/illumina/fastq/test_2.fastq.gz
        ```

### Reference data (`--genome`)

Many nf-core pipelines need a reference genome for alignment, annotation, or similar.

To make the use of reference genomes easier, Illumina developed a centralised resource called iGenomes where the most commonly used reference genome files are organised in a consistent structure.

nf-core have uploaded a copy of iGenomes onto AWS S3 and nf-core pipelines are configured to use this by default. All AWS iGenomes paths are specified in pipelines that support them in `conf/igenomes.config`. By default, the pipeline will automatically download the required reference files when you it is executed with an appropriate genome key (e.g., `--genome GRCh37`). The pipeline will only download what it requires.

Downloading reference genome files takes time and bandwidth so, if possible, it is recommend that you [download a local copy of your relevant iGenomes references](https://ewels.github.io/AWS-iGenomes/) and [configure your execution](https://nf-co.re/docs/usage/troubleshooting#using-a-local-version-of-igenomes) to use the local version.

When executing Sarek with common genomes, such as GRCh38 and GRCh37, iGenomes is shipped with the necessary reference files. However, depending on your deployment, it is sometimes necessary to use custom references for some or all files. Specific details for different deployment situations are described in the [usage documentation](https://nf-co.re/sarek/3.2.3/docs/usage/#how-to-run-sarek-when-not-all-reference-files-are-in-igenomes).

The small test `fastq.gz` files in the samplesheet created above would throw errors if it was run with a full size reference genome from iGenomes. Instead, smaller files from the nf-core test datasets repository need to be used. As these files are not included in iGenomes they must be specified manually using parameters.

The following parameters can be used to specify the required reference/annotation files for the small test data files:

```console
    --igenomes_ignore \
    --dbsnp "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/vcf/dbsnp_146.hg38.vcf.gz" \
    --fasta "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/genome.fasta" \
    --germline_resource "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/vcf/gnomAD.r2.1.1.vcf.gz" \
    --intervals "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/genome.interval_list" \
    --known_indels "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/vcf/mills_and_1000G.indels.vcf.gz" \
    --snpeff_db 105 \
    --snpeff_genome "WBcel235" \
    --snpeff_version "5.1" \
    --vep_cache_version "106" \
    --vep_genome "WBcel235" \
    --vep_species "caenorhabditis_elegans" \
    --vep_version "106.1" \
    --max_cpus 2 \
    --max_memory 6.5GB \
    --tools "freebayes" \
    --outdir "my_results"
```

!!! note "Tools"

    The `--tools` parameter is included above to trigger the execution of the freebayes variant caller. Multiple variant callers are available as a part of Sarek, however, in this example, only one is included.

!!! warning

    The `--igenomes_ignore` parameter must be included when using custom reference/annotation files. Without it, by default, the reference/annotation files that are typically required by Sarek are downloaded for `GATK.GRCh38`. Some pipelines have this feature by default while others require the genome flag (or alternate) for every execution.

### Profiles (`--profile`)

Software profiles are used to specify the software environment in which the pipeline will be executed. By simply including a profile (e.g., `singularity`), Nextflow will download, store, and manage the software used in the Sarek pipeline.

To ensure reproducibility, it is recommended that you use container technology, e.g., `docker` or `singularity`. 

## Putting it all together

The previous sections have shown different parts of a recommended run command. These can be combined to create a custom run command that will execute Sarek on the small test data files.

The completed run command will execute a small test set of files using the freebayes variant caller. The command will use the small test data files from the nf-core test datasets repository and custom reference/annotation files that are hosted on github.

!!! question "Exercise"

    Use all of the information above to build a custom run command that will execute version 3.2.3 of Sarek on the samplesheet you created.

    ??? tip "Hint"

        Include the sample sheet you made earlier with `--input samplesheet.csv`. Remember is must be in your working directory or you must specify the full or relative path to the file. If you named your samplesheet differently it must be reflected in your command.

        Include the parameters shown above to specify the reference/annotation files. You can copy these directly into your run command.

        Use Singularity to manage your software with `-profile singularity`.

    ??? success "Solution"

        Your run command should look like the following:

        ```bash
        nextflow run nf-core/sarek \
            --input samplesheet.csv \
            --igenomes_ignore \
            --dbsnp "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/vcf/dbsnp_146.hg38.vcf.gz" \
            --fasta "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/genome.fasta" \
            --germline_resource "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/vcf/gnomAD.r2.1.1.vcf.gz" \
            --intervals "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/genome.interval_list" \
            --known_indels "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/vcf/mills_and_1000G.indels.vcf.gz" \
            --snpeff_db 105 \
            --snpeff_genome "WBcel235" \
            --snpeff_version "5.1" \
            --vep_cache_version "106" \
            --vep_genome "WBcel235" \
            --vep_species "caenorhabditis_elegans" \
            --vep_version "106.1" \
            --max_cpus 2 \
            --max_memory 6.5GB \
            --tools "freebayes" \
            --outdir "my_results" \
            -profile singularity \
            -r 3.2.3
        ```

        If everything has worked - you will see the pipeline launching in your terminal 🚀

## Customizing parameters

In Session 1, we learned how to [customise a simple nf-core pipeline](../session_1/3_configuration.md). Here, we will apply these skills to customise the execution of the Sarek pipeline.

In the previous section we supplied a series of pipeline parameters as flags in your run command (`--`). Here, we will package these into a `.json` file and use the `-params-file` option.

!!! question "Exercise"

    Package the parameters from the previous lesson into a `.json` file and run the pipeline using the `-params-file` option:

    ```console
    nextflow run nf-core/sarek \
        --input samplesheet.csv \
        --igenomes_ignore \
        --dbsnp "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/vcf/dbsnp_146.hg38.vcf.gz" \
        --fasta "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/genome.fasta" \
        --germline_resource "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/vcf/gnomAD.r2.1.1.vcf.gz" \
        --intervals "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/genome.interval_list" \
        --known_indels "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/vcf/mills_and_1000G.indels.vcf.gz" \
        --snpeff_db 105 \
        --snpeff_genome "WBcel235" \
        --snpeff_version "5.1" \
        --tools "freebayes" \
        --vep_cache_version "106" \
        --vep_genome "WBcel235" \
        --vep_species "caenorhabditis_elegans" \
        --vep_version "106.1" \
        --max_cpus 4 \
        --max_memory 6.5GB \
        --output "my_results"
        -profile singularity \
        -r 3.2.3
    ```
    
    ??? success "Solution"

        ```json title="my-params.json"
        {
            "igenomes_ignore": true,
            "dbsnp": "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/vcf/dbsnp_146.hg38.vcf.gz",
            "fasta": "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/genome.fasta",
            "germline_resource": "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/vcf/gnomAD.r2.1.1.vcf.gz",
            "intervals": "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/genome.interval_list",
            "known_indels": "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/genome/vcf/mills_and_1000G.indels.vcf.gz",
            "snpeff_db": 105,
            "snpeff_genome": "WBcel235",
            "snpeff_version": "5.1",
            "tools":  "freebayes", 
            "vep_cache_version": 106,
            "vep_genome": "WBcel235",
            "vep_species": "caenorhabditis_elegans",
            "vep_version": "106.1",
            "max_cpus": 4,
            "max_memory": "6.5 GB",
            "outdir": "my_results_2"
        }
        ```

        Your execution command will now look like this:

        ```bash
        nextflow run nf-core/sarek --input samplesheet.csv -params-file my-params.json -profile singularity -r 3.2.3
        ```

        Note that in this example we kept `--input samplesheet.csv` in the execution command. However, this could have put this in the `.json` file. You can pick and choose which parameters go in a params file and which parameters go in your execution command.

Due to the order of priority, you can modify parameters you want to change without having to edit your newly created parameters file.

!!! question "Exercise"

    Include both `freebayes` and `strelka` as variant callers using the `tools` parameter and run the pipeline again.

    For this option, you will need to use the `--tools` flag and include both variant callers in the same string separated by a comma, e.g., `--tools "<tool1>,<tool2>"`

    You can also use `-resume` to resume the pipeline from the last successful step.

    ??? success "Solution"

        ```bash
        nextflow run nf-core/sarek --input samplesheet.csv -params-file my-params.json -profile singularity -r 3.2.3 --tools "freebayes,strelka" -resume 
        ```

## Configuration files

Sometimes Sarek won't have a parameter that you need to customize the execution of a tool. In this situation, you will need to apply a configuration file to the pipeline.

As shown in the example from [Session 1](../session_1/3_configuration.md), you can selectively apply a configuration file to a process using the `withName` directive.

!!! tip "Be specific with your selector"

    Remember to make your selector specific to the process you are trying to customise. It can be helpful to use the same selectors that are already included in the configuration file.

Sarek is a little different from other pipelines because it has multiple different config files that are used for different tools or groups of tools. This is stylistic and helps to keep the config files organised.

For example, there are a number of options that are applied when calling variants with `FREEBAYES` and are all stored in a [freebayes.config](https://github.com/nf-core/sarek/blob/3.2.3/conf/modules/freebayes.config) file together:

```console title="freebayes.config"
process {

    withName: 'MERGE_FREEBAYES' {
        ext.prefix       = { "${meta.id}.freebayes" }
        publishDir       = [
            mode: params.publish_dir_mode,
            path: { "${params.outdir}/variant_calling/freebayes/${meta.id}/" },
            saveAs: { filename -> filename.equals('versions.yml') ? null : filename }
        ]
    }

    withName: 'FREEBAYES' {
        ext.args         = '--min-alternate-fraction 0.1 --min-mapping-quality 1'
        //To make sure no naming conflicts ensure with module BCFTOOLS_SORT & the naming being correct in the output folder
        ext.prefix       = { meta.num_intervals <= 1 ? "${meta.id}" : "${meta.id}.${target_bed.simpleName}" }
        ext.when         = { params.tools && params.tools.split(',').contains('freebayes') }
        publishDir       = [
            enabled: false
        ]
    }

    withName: 'BCFTOOLS_SORT' {
        ext.prefix       = { meta.num_intervals <= 1 ? meta.id + ".freebayes" : vcf.name - ".vcf" + ".sort" }
        publishDir       = [
            mode: params.publish_dir_mode,
            path: { "${params.outdir}/variant_calling/" },
            pattern: "*vcf.gz",
            saveAs: { meta.num_intervals > 1 ? null : "freebayes/${meta.id}/${it}" }
        ]
    }

    withName : 'TABIX_VC_FREEBAYES' {
        publishDir       = [
            mode: params.publish_dir_mode,
            path: { "${params.outdir}/variant_calling/freebayes/${meta.id}/" },
            saveAs: { filename -> filename.equals('versions.yml') ? null : filename }
        ]
    }

    // PAIR_VARIANT_CALLING
    if (params.tools && params.tools.split(',').contains('freebayes')) {
        withName: '.*:BAM_VARIANT_CALLING_SOMATIC_ALL:BAM_VARIANT_CALLING_FREEBAYES:FREEBAYES' {
            ext.args       = "--pooled-continuous \
                            --pooled-discrete \
                            --genotype-qualities \
                            --report-genotype-likelihood-max \
                            --allele-balance-priors-off \
                            --min-alternate-fraction 0.03 \
                            --min-repeat-entropy 1 \
                            --min-alternate-count 2 "
        }
    }
}
```

Each of these can be modified independently of the others and be applied using a custom configuration file.

!!! question "Exercise"

    Create a custom configuration file that will modify the `--min-alternate-fraction` parameter for `FREEBAYES` to `0.05` and apply it to the pipeline.

    ??? success "Solution"

        ```bash
        nextflow run nf-core/sarek --input samplesheet.csv -params-file my-params.json -profile singularity -r 3.2.3 --tools "freebayes,strelka" -resume -c my-config.config
        ```

        ```console title="my-config.config"
        process {

            withName: 'FREEBAYES' {
                ext.args         = '--min-alternate-fraction 0.05 --min-mapping-quality 1'
            }
        }
        ```

## Metrics and reports

Nextflow can also produce multiple reports and charts that show several runtime metrics and your execution information. You can enable this functionality by adding Nextflow options to your run command:

- Adding `-with-report` to your run command will create a HTML execution report which includes many useful metrics about a pipeline execution. 
- Adding `-with-trace` option to creates an execution tracing file that contains some useful information about each process executed in your pipeline script.
- Adding `-with-timeline` to your run command enables the creation of the pipeline timeline report showing how processes were executed over time.
- Adding `-with-dag` to your run command enables the rendering of the pipeline execution direct acyclic graph representation.
    - This feature requires the installation of [Graphviz](https://graphviz.org/) on your computer. Beginning in version 22.04, Nextflow can render the DAG as a Mermaid diagram. Mermaid diagrams are particularly useful because they can be embedded in GitHub Flavored Markdown without having to render them yourself.

!!! square-pen "Note" 

    The execution report (`-with-report`), trace report (`-with-trace`), timeline trace (`-with-timeline`), and dag (`-with-dag`) must be specified when the pipeline is executed. By contrast, the `log` option is useful after a pipeline has already run and is available for every executed pipeline.

!!! question "Exercise"

    Try to run the following command and view the reports generated by Nextflow:
    
    ```bash
    nextflow run nf-core/sarek --input samplesheet.csv -params-file my-params.json -profile singularity -r 3.2.3 --tools "freebayes,strelka" -with-report -with-trace -with-timeline -with-dag -resume
    ```

<br>
!!! circle-info ""

!!! cboard-list-2 "Key points"

    - Sarek comes with a test profiles that can be used to test the pipeline on your infrastructure
    - Sample sheets are `csv` files that contain important meta data and the paths to your files
    - Reference files are available from iGenomes
    - Parameters go in parameters files and everything else goes in a configuration file
    - There are additional flags you can use to generate reports and metric for you own records
