# rule to run the fresco input file,
# then save all of the outputs to the specified output directory 

rule run_input:
    input:
        input_file = "input/example-br.in"
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
