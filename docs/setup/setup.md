# Log into Nesi

During this workshop we will be running the material on the NeSI platform, using the Jupyter interface, however it is also possible to run this material locally on your own machine.

One of the differences between running on NeSI or your own machine is that on NeSI we pre-install popular software and make it available to our users, whereas on your own machine you need to install the software yourself (e.g., using a package manager such as conda).

??? jupyter "Connect to Jupyter on NeSI"

    1. Connect to [https://jupyter.nesi.org.nz](https://jupyter.nesi.org.nz)
    2. <p>Enter NeSI username, HPC password, and 6 digit second factor token (as set on <a href="https://my.nesi.org.nz/account/hpc-account">MyNeSI</a>)<br>![image](../images/jupyter_login_labels_updated.png)</p>
    3. <p>Choose server options as below
    <br>make sure to choose the correct project code `nesi02659`, number of CPUs **4**, memory **8GB** prior to pressing ![image](./nesi_images/start_button.png){width="60"} button. <br>![image](../images/jupyter_server2023.png){width="700"}
    4. <p>Start a terminal session from the JupyterLab launcher<br>![image](../images/terminal_view.png){width="500"}

## Loading required software

This workshop will use a combination of "environment modules" and manually installed software.

We will need to prepare our environment by running the following commands to clear the environment and then load the required software. This installation is only required once per session:

```bash
module purge
module load Miniconda3
source $(conda info --base)/etc/profile.d/conda.sh
module load Singularity/3.11.3
module load Java/17
module load Python/3.10.5-gimkl-2022a
module load Graphviz/2.42.2-GCC-9.2.0

conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

conda create --name nf-core python=3.11 nf-core nextflow

conda activate nf-core
```

This will take a few minutes to complete...

More details about environment modules can be found on the [NeSI support page](https://support.nesi.org.nz/hc/en-gb/articles/360000360576-Finding-Software).
