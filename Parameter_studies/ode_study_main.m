setup;
warning("off");
clear base_UI_loading_bar

num_sims             = 7;
my_rocket            = Mjollnir();
my_rocket.atmosphere.dataset = random_wind_dataset("02185", datetime(2010, 1, 1), datetime(2025, 06, 21));
job = struct(); job.t_max = 300;
rocket_historians    = cell(num_sims,1);
jobs                 = repmat({job},1,num_sims);
jobs{1}.ode_solver   = @ode45;
jobs{2}.ode_solver   = @ode15s;
%jobs{3}.ode_solver   = @ode23;
jobs{3}.ode_solver   = @ode23s;
jobs{4}.ode_solver   = @ode23t;
jobs{5}.ode_solver   = @ode78;
jobs{6}.ode_solver   = @ode89;
jobs{7}.ode_solver   = @realtime_ode;


for i = 1:num_sims
    rocket_historians{i} = run_simulation(my_rocket , jobs{i});
end


save("./Parameter_studies/ode_study.mat")

plotting_routine_parameter_study