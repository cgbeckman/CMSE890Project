# Fresco Ouputs 

Fresco calculates many reaction observables which are stored in the fort files. The reaction observables of interest for the calculation are the 
breakup cross section angular distribution. This cross-section is determined by angular integration over energy. The integration is performed by a 
secondary function called sumbins, which must be compiled separately from compiling fresco. It is stored in fres/util. Passing the file fort.16, which 
contains the cross-sections for each angular momentum partial wave included in the calculation. 

The other observable of interest is the relative energy distribution between the core and valence components. The relative energy distributions are 
obtained by integrating the contents of fort.13 over all angles included in the calculation. This integration is done by the sumxen function, which 
also needs to be compiled. This function is also stored in fres/util.

The next section gives details on the workflow for using Fresco to do a CDCC calculation.
