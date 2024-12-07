# To run all of tbe rules in this Snakefile, all outputs of each rule must 
# be included in the rule all. 
rule all: 
    input: "outputs/output_file/example-br.out",
           "input/long_input.in",
           "outputs/plots/brkup_cs.png",
           "outputs/plots/s_half_relative_energy.png",
           "outputs/test_results/fort16_test.txt"
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
    log: "logs/run_calculations.log"  
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

# Rule test the result of the calculation
rule test_nan: 
    input: "outputs/fort_files/fort.16"
    output: "outputs/test_results/fort16_test.txt"
    shell: "python3 python_scripts/tests/NaN_test.py > {output}" 
   
# Rule to plot the total breakup cross section
rule plot_brkup_cs: 
    input: 
        input_file = "outputs/integrated_cross_sections/energy_integration.txt"
    output: 
        output_file = "outputs/plots/brkup_cs.png"
    script:
        "python_scripts/brkup_cross_section.py"

# Plot the relative energy distribution
rule plot_relative_energy:
    input:
        input_file = "outputs/integrated_cross_sections/angle_integration.txt"
    output:
        output_file = "outputs/plots/s_half_relative_energy.png"
    script:
        "python_scripts/relative_energies.py"


