# To run all of tbe rules in this Snakefile, all outputs of each rule must 
# be included in the rule all. 
rule all: 
    input: "outputs/output_file/example-br.out",
           "input/long_input.in",
           "outputs/plots/brkup_cs.png"

# Rule to run the fresco calculation
rule run_input:
    input:
        input_file = "input/example-br.in",
    output:
        output_file1 = "outputs/output_file/example-br.out",
        output_file2 = "input/long_input.in"
   # Set memory resource for job submission
    resources:
        mem_mb = 4000
    threads: 4
    shell:
        """
        fresco/cdc < {input.input_file} > {output.output_file2}
        fresco/fresco < {output.output_file2} > {output.output_file1}
        fresco/sumbins < fort.16 > energy_integration.txt
        fresco/sumxen < fort.13 > angle_integration.txt
        for file in fort*; do mv $file outputs/fort_files/; done
        mv energy_integration.txt outputs/integrated_cross_sections/
        mv angle_integration.txt outputs/integrated_cross_sections/
        """

# Rule to plot the total breakup cross section
rule plot_brkup_cs: 
    input: 
        input_file = "outputs/integrated_cross_sections/energy_integration.txt"
    output: 
        output_file = "outputs/plots/brkup_cs.png"
    run: 
        import matplotlib.pyplot as plt
        import os 
        print("Starting to run python")
        # start of script to read in file
        content = []
        theta= []
        CS = []

        
        with open(input.input_file) as file:
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
        plt.savefig('output[0]')
