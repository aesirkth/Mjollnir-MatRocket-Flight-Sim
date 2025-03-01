setup;

my_rocket = Mjollnir;

job = struct(); job.t_max = 120;
rocket_historian = run_simulation(my_rocket, job);


delete    (".\Rocket_source\Mjollnir\Output\flight.txt")
struct2txt(".\Rocket_source\Mjollnir\Output\flight.txt", rocket_historian, 0:1/30:job.t_max);

plots