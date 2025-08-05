setup;
clear all;
my_rocket = Mjollnir();
my_rocket.atmosphere.dataset = random_wind_dataset("02185", datetime(2010, 1, 1), datetime(2025, 06, 21));

job = struct(); job.t_max = 300;

rocket_historian = run_simulation(my_rocket, job);

rocket_historian = query_historian(rocket_historian, 0:1/30:job.t_max);

delete (".\Output\flight.csv")
obj2csv(".\Output\flight.csv", rocket_historian);
save(".\Output\flight.mat")
plots