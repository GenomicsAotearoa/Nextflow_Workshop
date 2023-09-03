# Building your own run command



## Where to start

The recommended run command can be used as a starting point for customising a run command.

```bash
nextflow run nf-core/sarek --input samplesheet.csv --genome GATK.GRCh38 -profile docker
```

From here, the command can be customised to suit your needs. The following sections will describe the different components of the command and how they can be customised. Small test data files that are hosted on github will be used to demonstrate how to customise the workflow, but the same concepts will apply to your own data.

### Input (`--input`)

The Sarek workflow requires a samplesheet as an input parameter. This is a `csv` file that contains information about the samples to be processed. The samplesheet is used to specify the location of the input data, the sample name, and any additional metadata.

A samplesheet is created manually and can be stored anywhere on your computer. The samplesheet can be named anything you like, but it must be specified using the `--input` flag.

More information about how to create a samplesheet for Sarek can be found in the [usage documentation](https://nf-co.re/sarek/3.2.3/docs/usage/#input-sample-sheet-configurations).

Note how Sarek can accept different data types as inputs and how the samplesheet are customized for each.

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

        ```csv
        patient,sex,status,sample,lane,fastq_1,fastq_2
        test,XX,0,test,test_L1,https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/illumina/fastq/test_1.fastq.gz,https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/genomics/homo_sapiens/illumina/fastq/test_2.fastq.gz
        ```

### Reference data

Many nf-core pipelines need a reference genome for alignment, annotation, or similar.

To make the use of reference genomes easier, Illumina developed a centralised resource called iGenomes where the most commonly used reference genome files are organised in a consistent structure.

nf-core have uploaded a copy of iGenomes onto AWS S3 and nf-core pipelines are configured to use this by default. All AWS iGenomes paths are specified in pipelines that support them in `conf/igenomes`.config. By default, the pipeline will automatically download the required reference files when you run the pipeline and supply an appropriate genome key (e.g., `--genome GRCh37`). The pipeline will only download what it requires.

When using AWS iGenomes, for convenience, when a reference asset is available for direct download, these parameters are essentially auto-populated based on what is defined in `conf/igenomes.config` when you provide the `--genome` parameter.

Downloading reference genome files takes time and bandwidth so, if possible, it is recommend that you [download a local copy of your relevant iGenomes references](https://ewels.github.io/AWS-iGenomes/) and [include them in your execution](https://nf-co.re/docs/usage/troubleshooting#using-a-local-version-of-igenomes).

When executing Sarek with common genomes, such as GRCh38 and GRCh37, igenomes is shipped with (almost) all necessary reference files. However, depending on your deployment, it is sometimes necessary to use custom references for some or all files. Specific details for different deployment situations are described in the [usage documentation](https://nf-co.re/sarek/3.2.3/docs/usage/#how-to-run-sarek-when-not-all-reference-files-are-in-igenomes).

The small test `fastq.gz` files in the samplesheet created above would throw errors if run with a full genome. Instead, smaller files from the nf-core test datasets repository are need to be used. As these files are not resolved they must be specified manually using parameters.

The following parameters can be used to specify the required reference/annotation files for the small test data files:

```bash
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
    --tools "freebayes"
```

!!! note "Tools"

    The `--tools` parameter is included above to trigger the execution of the freebayes variant caller. Multiple variant callers are available as a part of Sarek, however, only one is included here as an example.

!!! warning

    The `--igenomes_ignore` parameter must be included when using custom reference/annotation files. Without it, by default, the reference/annotation files that are typically required by Sarek are downloaded for `GATK.GRCh38`.

### Profiles (`--profile`)

Software profiles are used to specify the software environment in which the workflow will be executed. By simply including a profile (e.g., `singularity`), Nextflow will download, store, and manage the required software images/containers/environments when you execute Sarek.

To ensure reproducibility, it is recommended that you use container technology, e.g., `docker` or `singularity`. 

## Putting it all together

The previous sections have shown different parts of a recommended run command. These can be combined to create a custom run command that will execute Sarek on the small test data files.

The completed run command will execute a small test set of files using the freebayes variant caller. The command will use the small test data files from the nf-core test datasets repository and custom reference/annotation files that are hosted on github.

!!! question "Exercise"

    Use all of the information above to build a custom run command that will execute Sarek on the small test data files.

    ??? tip "Hint"

        Include the sample sheet you made earlier with `--input samplesheet.csv`. Remember is must be in your working directory or you must specify the full or relative path to the file. If you named your samplesheet differently it must be reflected in your command.

        Include the parameters shown above to specify the reference/annotation files. You can copy these directly into your run command.

        Use Singularity to manage your software with `-profile singularity`.

    ??? success "Solution"

        ```bash
        nextflow run nf-coresarek \
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
            --tools "freebayes" \
            -profile singularity
        ```

!!! abstract "Key points"

    - The 