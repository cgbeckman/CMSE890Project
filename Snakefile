# define directory 
home_dir = "/mnt/home/beckma75/CMSE890Project"


# rule to run the fresco input file,
# then save all of the outputs to the specified output directory 

rule run_input: 
    input: f"{home_dir}/input/example-br.run"
    output: f"{home_dir}/outputs/output_file/example-br.out"
    log: 
        f"{home_dir}/logs/run_calculation/"
   # Set memory resource for job submission
    resources: 
        mem_mb = 4000 
    threads: 4
    shell:
        '''
        chmod +x {input} 
        .{input} 
        {home_dir}/fresco/sumbins < fort.16 > energy_integration.txt
        {home_dir}/fresco/sumxen < fort.13  > angle_integration.txt
        for file in fort*; do
            mv "$file" {home_dir}/outputs/fort_files/;
        done    
        mv example-br.out {home_dir}/outputs/output_file
        mv cdc.in {home_dir}/input/
        mv long_in.in {home_dir}/input/
        mv energy_integration.txt {home_dir}/outputs/integrated_cross_sections/
        mv angle_integration.txt {home_dir}/outputs/integrated_cross_sections/
        '''

# Clean rule is redundant, you're using mv above not cp
#rule clean: 
 #   shell: '''
  #        for file in fort*; do
   #          rm "$file";
    #      done
     #     '''  

# Rule to plot the total breakup cross section
rule plot_brkup_cs: 
    input: "{home_dir}/outputs/energy_integration.txt"
    output: "{home_dir}/outputs/plots/brkup_cs.png"
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
#rule move_plot:
 #   input: "brkup_cs.png"
  #  output: "~/outputs/plots/brkup_cs.png"
   # shell: f"mv {input} {output}"
