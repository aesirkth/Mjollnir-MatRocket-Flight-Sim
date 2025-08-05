function rocket = send_to_fjalar(rocket)
persistent init
persistent message

if isempty(init)
    message = rocket.HIL.protobuf.HilOut();
    init = false;
end


py.setattr(message, 'ax', rocket.acceleration(1));
py.setattr(message, 'ay', rocket.acceleration(2));
py.setattr(message, 'az', rocket.acceleration(3));

py.setattr(message, 'gx', rocket.rotation_rate(1));
py.setattr(message, 'gy', rocket.rotation_rate(2));
py.setattr(message, 'gz', rocket.rotation_rate(3));

py.setattr(message, 'p', rocket.atmosphere.pressure*1e-3);
raw_bytes = message.SerializeToString();
byte_array = uint8(raw_bytes);
write(rocket.serialport, byte_array, "uint8");


end