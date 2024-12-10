**************************************************************************************
*                                                                                    *
*          Reproducible Workflow for a Nuclear Breakup Calculation                   *
*                     CMSE 890 Fall 2024 Course Project                              *
*                     Author: Cate Beckman                                           *
**************************************************************************************

This respository is a start to finish workflow to run a breakup calculation using the Continuum Discretized Coupled Channels Method. 

The input file for the calcution is stored under workflow/input, and the reaction information can be altered. 
In workflow/, a Snakefile exists which runs the calculation using Fresco, tests the calculation ran, tests the outputs
are not NaN, and finally plots the results. Additionally, an sbatch file exists in the workflow directory. This sbatch
file runs the Snakefile for the user. The workflow makes use of a tool called snakemake, which requires an environment 
specified in environemnt.yaml. The .yaml file is stored in project_details/, and the environment is called CMSEProject890.

Steps to run: 
1) Download and compile Fresco.                                                                                                             
   a) This can be done on hpcc by cloning this repository, a precompiled
   version of Fresco is located in the folder called Fresco.                                                                             
   b) Alternatively, Fresco can be downloaded and compiled following the instructions at https://www.fresco.org.uk/source/installation.htm
2) If desired, edit the reaction information in the input file. The example input file in this repository is
   for a 15C elastic scattering on a deuteron target, using the Continuum Discretized Coupled Channels method.                                             
3) Run the workflow.                                                                                                                                     
   a) To run the workflow, activate the environment in command line using "conda activate CMSEProject890". Then                        
      run "snakemake" in the command line to run the workflow.                                                                               
   b) Alternatively, one can submit the workflow to anywhere that uses slurm for job submission. In the workflow/                         
      directory a run_workflows.sb file exists. Entering "sbatch run_workflow.sb" submits the workflow to the system.

Outputs:                                                                                                                                     
Fresco is quite comprehensive nuclear reactions program, that calculates many observables. These observables are stored in each fort.xxx file, which are 
stored in the directory "outputs/fort_files/". For a breakup reaction, the observables of interest are the angle and energy integrated cross-sections. 
1) Angle integrated cross-sections: The differential cross section in relation to the energy is calculated by Fresco and output into fort.13. The angle integration of these values calculates the relative energy between the core and valence components that broke apart. This angular integration is performed by passing fort.13 to the program sumxen, which is done in this workflow. 
2) Energy integrated cross-sections: The other observable of interest is the energy integrated angular distribution for elastic scattering. The differential elastic scattering cross-sections are calculated and stored in fort.16. In this workflow, the energy integrated angular distribution is obtained by passing fort.16 to the program sumbins.
