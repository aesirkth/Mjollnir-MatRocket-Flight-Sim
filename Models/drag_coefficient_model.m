function rocket = drag_coefficient_model(rocket)

altitude = rocket.position(3);
[~,speed_of_sound,~,~] = atmoscoesa(altitude);
mach = norm(rocket.velocity)/speed_of_sound;
rocket.aerodynamics.pressure_coefficient(3) = drag_coefficient(altitude, mach);

end