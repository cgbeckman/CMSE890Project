**************************************************************************************
*                                                                                    *
*          Reproducible Workflow for a Nuclear Breakup Calculation                   *
*                     CMSE 890 Fall 2024 Course Project                              *
*                     Author: Cate Beckman                                           *
**************************************************************************************


This respository is a start to finish  workflow to run a breakup calculation.
The repository uses user prompts to fill in an input file, and then runs the calculation
in fresco, and finally plots the results. The workflow makes use of a tool called snakemake,
which requires an environment specified in environemnt.yaml. This environemtn is called CMSEProject890.

Steps to run: 
1) Download and compile fresco. This can be done on hpcc by cloning this repository, a precompiled
   version of fresco is located in the folder called fresco.
2) Run the input file function. This function will prompt you for parameters to fill out the input file
   for a breakup calculation. 
3) When the input file is finished, submit the .sb file called TODO to hpcc. This file runs
   snakemake, which takes care of running the calculation and then plotting the outputs.


Done: 
Added nuclide-data as a submodule. Users that clone the repository may need to use git clone --recursive <project url> in order to get this dependency
Start snakefile. run_input rule works perfectly 

TODO
-fix python rule 
-fix integration rules. They seem to not be working 
-add rule to plot other observables (elastic scattering cross section, mod smatrices, etc)
-make a documentation website 

