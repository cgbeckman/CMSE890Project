# To run all of tbe rules in this Snakefile, all outputs of each rule must 
# be included in the rule all. 
rule all: 
    input: "outputs/output_file/example-br.out",
           "input/long_input.in",
           "outputs/plots/brkup_cs.png",
           "outputs/plots/s_half_relative_energy.png",
           "outputs/test_results/fort16_exists.txt",
           "outputs/test_results/fort16_nan.txt",
           "outputs/test_results/fort13_test.txt",
           "outputs/test_results/angle_int_test.txt",
           "outputs/test_results/energy_int_test.txt"

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
# Rule to test if fresco ran and produced necessary outputs
rule test_fresco:
    input: "outputs/fort_files/fort.16"
    output: "outputs/test_results/fort16_exists.txt"
    shell: "pytest python_scripts/tests/test_fresco.py > {output} 2>&1"
   
# Rule to check the calculation worked, and didn't output NaN 
rule test_nan: 
    input: "outputs/fort_files/fort.16" 
    output: "outputs/test_results/fort16_nan.txt"
    shell: "pytest python_scripts/tests/test_NaN.py > {output} 2>&1"

# Rule test the result of the angle integration calculation
rule test_relE: 
    input: "outputs/fort_files/fort.13"
    output: "outputs/test_results/fort13_test.txt"
    shell: "pytest python_scripts/tests/test_relE.py > {output} 2>&1"

# Rule to test the results of the angular integration
rule test_angle_int: 
    input: "outputs/integrated_cross_sections/angle_integration.txt"
    output: "outputs/test_results/angle_int_test.txt"
    shell: "pytest python_scripts/tests/test_angle_int.py > {output} 2>&1"

# Rule to test the results of the energy integration
rule test_energy_int:
    input: "outputs/integrated_cross_sections/energy_integration.txt"
    output: "outputs/test_results/energy_int_test.txt"
    shell: "pytest python_scripts/tests/test_energy_int.py > {output} 2>&1"

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


