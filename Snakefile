# define directory 
home_dir = "/mnt/home/beckma75"

# rule to run the fresco input file,
# then save all of the outputs to the specified output directory 

rule run_input: 
    input:  f"{home_dir}/scat_snakemake/input/example-br.run"
    output: f"{home_dir}/scat_snakemake/outputs/example-br.out"
    params: 
        output_dir = f"{home_dir}/scat_snakemake/outputs/"
   # Set memory resource for job submission
    resources: 
        mem_mb = 4000 
    threads: 4
    shell:
        '''
        set -x
        chmod +x {input} 
        {input} 
        for file in fort*; do
            mv "$file" {params.output_dir};
        done    
        mv example-br.out {home_dir}/scat_snakemake/outputs/
        mv example-br.in {home_dir}/scat_snakemake/input/
        '''
rule clean: 
    shell: '''
          for file in fort*; do
             rm "$file";
          done
          '''  
# Rule to integrate differential cross section with respect to dE
rule energy_integration:
    input: f"{home_dir}/outputs/fort.16"
    output: f"{home_dir}/outputs/angdist_int_energy"
    shell: '''
           {home_dir}/fres/util/sumbins < {input} > {output}
           '''
# Rule to integrate fort.13 with respect to angle 
rule angular_integration:
    input: f"{home_dir}/outputs/fort.13"
    output: f"{home_dir}/outputs/angdist_int_angle"
    shell: '''
           {home_dir}/fres/util/sumxen < {input} > {output}
           '''
# Rule to plot the total breakup cross section
rule plot_brkup_cs: 
    input: f"{home_dir}/outputs/angdist_int_energy"
    output: f"{home_dir}/outputs/brkup_cs.png"
    run: 
        import matplotlib.pyplot as plt
        import os 
        print("Starting to run python")
        # start of script to read in file
        content = []
        theta= []
        CS = []
          
        if os.path.isfile(input[0]):
            print(f'File  exists')
            with open(input[0]) as file:
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
        plt.plot(theta, CS)
        plt.xlabel('COM Angle')
        plt.ylabel('Total Breakup Cross-Section (mb/str)')
        plt.title('Breakup Angular Distribution')
        plt.savefig("brkup_cs.png")

# Move breakup cross section to output directory
rule move_plot:
    input: "brkup_cs.png"
    output: f"{home_dir}/outputs/brkup_cs.png"
    shell: "mv {input} {output}"
