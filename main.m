setup;

my_rocket = Mjollnir();

job = struct(); job.t_max = 120;
rocket_historian = run_simulation(my_rocket, job);

rocket_historian = query_historian(rocket_historian, 0:1/30:job.t_max);

delete (".\Output\flight.csv")
obj2csv(".\Output\flight.csv", rocket_historian);

plots