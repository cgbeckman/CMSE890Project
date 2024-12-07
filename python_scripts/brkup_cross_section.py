import matplotlib.pyplot as plt
import os
        
print("Starting to run python")
# start of script to read in file

theta= []
CS = []


with open(snakemake.input[0]) as file:
    for line in file:
        count = 0
        strip = line.strip().split()
        print("File read")
        if len(strip) > 1:
            try:
                theta.append(float(strip[0]))
                CS.append(float(strip[1]))
            except ValueError:
                 continue
        else:
             print(f'File  does not exist')

# Plot the result

plt.figure()
plt.plot(theta, CS)
plt.xlabel('COM Angle')
plt.ylabel('Total Breakup Cross-Section (mb/str)')
plt.title('Breakup Angular Distribution')
plt.show()
plt.savefig(snakemake.output[0])
