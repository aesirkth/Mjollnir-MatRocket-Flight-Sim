setup_FIL
my_rocket = Mjollnir_FIL();


job = struct(); job.t_max = 25; job.ode_solver = @realtime_ode;

rocket_historian = run_simulation(my_rocket, job);
if isfile(".\Output\flight.csv")
delete(".\Output\flight.csv");
end
obj2csv(".\Output\flight.csv", query_historian(rocket_historian, 0:1/60:job.t_max))
plots

