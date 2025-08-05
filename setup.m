
pip_libraries = {"MatlabBlenderIO", "MatRocket"};

for index = 1:numel(pip_libraries)
library = pip_libraries{index};
[failiure, library_status] = system("pip show "+library);
if failiure
system("pip install "+library);
[failiure, library_status] = system("pip show "+library);
end

library_path = strip(extractBetween(string(library_status), "Location: ", "Requires:"))+"\"+library;
addpath(genpath(library_path));
disp(library +" loaded successfully.")
end
addpath(".\Rocket_source\")
addpath(".\Rocket_source\Wind_Data\")
addpath(".\Output\")
addpath(".\Models\")
addpath(".\Parameter_studies\")
addpath(".\lib\")
addpath(".\Fjalar_in_the_loop\")
