setup;

my_rocket = Mjollnir();
%order = 4;
%my_rocket.models = {my_rocket.models{1:order-1}, @drag_coefficient_model, my_rocket.models{order:end}};

my_rocket.engine.thrust_force = 3300;
my_rocket.atmosphere.wind_velocity = [2;0;0];
job = struct(); job.t_max = 300;

rocket_historian = run_simulation(my_rocket, job);

rocket_historian = query_historian(rocket_historian, 0:1/30:job.t_max);

delete (".\Output\flight.csv")
obj2csv(".\Output\flight.csv", rocket_historian);
save(".\Output\flight.mat")
plots