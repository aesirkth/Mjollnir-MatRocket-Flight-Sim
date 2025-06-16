function rocket = atmosphere_model(rocket, file)

persistent init
persistent pressure
persistent temperature
persistent density
persistent speed_of_sound
persistent wind_velocity

% On startup
if isempty(init)
rawdata = readmatrix(file);
raw_pressure       = rawdata(:,4);
raw_altitude       = rawdata(:,5);
raw_temperature    = rawdata(:,6);
raw_wind_direction = rawdata(:,12);
raw_wind_magnitude = rawdata(:,13);


raw_pressure       = [raw_pressure(1)       ; raw_pressure(:)      ];
raw_altitude       = [-1                    ; raw_altitude(:)      ];
raw_temperature    = [raw_temperature(1)    ; raw_temperature(:)   ];
raw_wind_direction = [raw_wind_direction(1) ; raw_wind_direction(:)];
raw_wind_magnitude = [raw_wind_magnitude(1) ; raw_wind_magnitude(:)];

air_molar_mass          = 28.97*1e-3;
R                       = 8.31446261815324;
celsius2kelvin          = 273.15;
air_specific_heat_ratio = 1.4;



pressure       = @(h) makima(raw_altitude, raw_pressure,    h)*1e2;
temperature    = @(h) makima(raw_altitude, raw_temperature, h);
density        = @(h) pressure(h) * air_molar_mass/(R * (temperature(h) + celsius2kelvin));
speed_of_sound = @(h) sqrt(air_specific_heat_ratio * R * temperature(h));
wind_velocity  = @(h) makima(raw_altitude, raw_wind_magnitude, h).*[sind(makima(raw_altitude, raw_wind_direction, h));
                                                                    cosd(makima(raw_altitude, raw_wind_direction, h));
                                                                    0];


init = false;
end


rocket.atmosphere.pressure       = pressure(rocket.position(3));
rocket.atmosphere.temperature    = temperature(rocket.position(3));
rocket.atmosphere.density        = density(rocket.position(3));
rocket.atmosphere.speed_of_sound = speed_of_sound(rocket.position(3));
rocket.atmosphere.wind_velocity  = wind_velocity(rocket.position(3));




end