function [pressure, temperature, speed_of_sound, wind_velocity, density] = initiate_atmosphere(file)


rawdata = readmatrix(file);
raw_pressure       = rawdata(:,4);
raw_altitude       = rawdata(:,5);
raw_temperature    = rawdata(:,6);
raw_wind_direction = rawdata(:,12);
raw_wind_magnitude = rawdata(:,13);


air_molar_mass          = 28.97;
R                       = 8.31446261815324;
celsius2kelvin          = 273.15;
air_specific_heat_ratio = 1.4;



pressure       = @(h) makima(raw_altitude, raw_pressure,    h);
temperature    = @(h) makima(raw_altitude, raw_temperature, h);
density        = @(h) pressure(h) * air_molar_mass/(R * (temperature(h) + celsius2kelvin));
speed_of_sound = @(h) sqrt(air_specific_heat_ratio * R * temperature(h));
wind_velocity  = @(h) makima(raw_altitude, raw_wind_magnitude, h)*[sind(makima(raw_altitude, raw_wind_direction, h));
                                                                   cosd(makima(raw_altitude, raw_wind_direction, h));
                                                                   0];



end