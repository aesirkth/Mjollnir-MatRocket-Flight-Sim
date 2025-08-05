
setup;
warning("off");



num_sims             = 10;
my_rocket            = Mjollnir();
rocket_historians    = cell(num_sims,1);
rockets              = cell(num_sims,1);

for i = 1:num_sims
my_rocket.engine.thrust_force = (i)/(10)*2000 +1000;
rockets{i} = my_rocket;
end

for i = 1:num_sims
    disp("job " + string(i) +" started.")
    job                    = struct(); 
    job.t_max              = 300;
    rocket_historians{i} = run_simulation(rockets{i} , job);
    disp("job " + string(i) +" finished.")
    save("Parameter_studies\thrust_study.mat")
end

save("Parameter_studies\thrust_study.mat")
plotting_routine_parameter_study