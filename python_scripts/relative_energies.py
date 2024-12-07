#Script to plot the relative energy distrubtion between the 14C-n core 

import matplotlib.pyplot as plt
import os 

# Preallocate variables 
s12energy = []
s12CS = []

# Read in the angle integrated file 
with open(snakemake.input[0]) as file:
        for line in file:
            count=0
            strip = line.strip().split()
            if len(strip) == 2 and '@legend' not in strip: 
                if count < 13:
                    s12energy.append(float(strip[0]))
                    s12CS.append(float(strip[1]))
                    count += 1
            else: 
                continue

# Plot the relative energy distribution for the s-1/2 partial wave
plt.figure()
plt.scatter(s12energy, s12CS, s=5)
plt.xlabel('Energy (MeV)')
plt.ylabel('Cross Section (mb)')
plt.title('Total Cross Section for 14C-n Relative Energy (s-1/2)')
plt.xticks(rotation=45)
plt.savefig(snakemake.output[0], dpi=300)
plt.show() 