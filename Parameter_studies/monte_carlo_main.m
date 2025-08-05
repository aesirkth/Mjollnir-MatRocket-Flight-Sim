setup;

if isfile(".\Parameter_studies\monte_carlo.mat")
load(".\Parameter_studies\monte_carlo.mat")
else

my_rocket = Mjollnir();

job = struct(); job.t_max = 270;

%% Paramters to vary:

thrust_force = 2700:10:4400;

drag_coefficient_offset = 0.8:0.01:1.5;


sim_nr = 1;
max_sims = 1e3;

rocket_historians = cell(1,max_sims);

save(".\Parameter_studies\monte_carlo.mat", '-v7.3')
end


while sim_nr < max_sims
clear atmosphere_model
try
my_rocket.atmosphere.dataset                   = random_wind_dataset("02185", datetime(2010, 1, 1), datetime(2025, 06, 21));
my_rocket.engine.thrust_force                  = thrust_force(randi(numel(thrust_force)));
my_rocket.aerodynamics.drag_coefficient_offset = drag_coefficient_offset(randi(numel(drag_coefficient_offset)));

rocket_historians{sim_nr} = run_simulation(my_rocket, job);

sim_nr = sim_nr +1;
save(".\Parameter_studies\monte_carlo.mat", '-v7.3')
catch
end

end

%rocket_historian = run_simulation(my_rocket, job);


%plots