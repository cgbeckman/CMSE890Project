# Fresco Details

Fresco is a code which solves coupled channels problems for nuclear reactions. To install Fresco to use this workflow there are a few options. 


Download and compile Fresco.<br />
a) This can be done on hpcc by cloning this repository, a precompiled version of Fresco is located in the directory "workflow/fresco". b) The source 
code is located in the directory fres. Follow the instructions to compile there.<br />
c) Alternatively, Fresco can be downloaded and compiled following the instructions at [link](https://www.fresco.org.uk/source/installation.htm).

## Input 

To run a CDCC calculation using Fresco, there are inputs that need to be decided upon. In the section Example-15C(d,d')15C, and on the github 
repository for this workflow, is an example which has a correct input file for carbon-15 scattering on deuteorn. The important inputs are detailed 
below. 

**1. Target and Projectile Information:** This information is included in the &NUCLEUS section of the input file, which details the mass partitions in 
the 
reaction. Charge, mass number, and binding energy are needed. <br /> 
**2. Interactions:** The potentials which correspond to the interaction in each mass partition need to be included in the &POT section. These 
potentials can be found online using RIPL3.<br /> 
**3. Continuum Discretization:** The &BIN section is where the user sets the continuum discretization for each partial wave included in the 
calculation. The energy mesh is defined with start, step, and 
stop. If energy is set to T, the mesh is in energy, if energy is set to F, the mesh is in momentum. 

The next section gives detail on Fresco outputs.
