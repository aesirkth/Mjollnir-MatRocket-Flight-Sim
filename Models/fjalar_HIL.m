function rocket = fjalar_HIL(rocket)


local_acceleration = rocket.attitude' * rocket.acceleration;

local_rotation_rate = rocket.attitude' * rocket.rotation_rate;

[~,~,pressure,~] = atmoscoesa(rocket.position(3));

clear_que(rocket.Fjalar.output_stream);
send(rocket.Fjalar.output_stream, {local_acceleration, local_rotation_rate, pressure});

end