function rocket = send_to_fjalar(rocket)

persistent init


if isempty(init)

%% Do all the initiation shit here, runs on first simulation iteration


init = false;
end



FjalarMessage = rocket.HIL.protobuf.FjalarMessage();
FjalarData    = rocket.HIL.protobuf.FjalarData();
HilIn         = rocket.HIL.protobuf.HilIn();

persistent init;
if isempty(init)
    for i=[0:60]
        py.setattr(HilIn, 'ax', 0);
        py.setattr(HilIn, 'ay', 0);
        py.setattr(HilIn, 'az', 0 + 9.81); % adding gravity to mimic behaviour of accelerometer
        py.setattr(HilIn, 'gx', 0);
        py.setattr(HilIn, 'gy', 0);
        py.setattr(HilIn, 'gz', 0);
        py.setattr(HilIn, 'p', rocket.atmosphere.pressure * 1e-3)
        py.setattr(HilIn, 'awaiting_init', true);
        py.setattr(HilIn, 'awaiting_launch', false);

        % Correctly assign HilIn to FjalarData using CopyFrom
        py.getattr(FjalarData, 'hil_in').CopyFrom(HilIn);
        
        % Assign FjalarData to FjalarMessage
        py.getattr(FjalarMessage, 'data').CopyFrom(FjalarData);
        
        write(rocket.serialport, encode_message(FjalarMessage), "uint8")
        pause(0.02);
    end
    init = true;
end 
                
% Populate HilIn fields

acceleration_local = (rocket.attitude') * rocket.acceleration;

py.setattr(HilIn, 'ax', acceleration_local(1));
py.setattr(HilIn, 'ay', acceleration_local(2));
py.setattr(HilIn, 'az', acceleration_local(3) + 9.81); % adding gravity to mimic behaviour of accelerometer
py.setattr(HilIn, 'gx', rocket.rotation_rate(1));
py.setattr(HilIn, 'gy', rocket.rotation_rate(2));
py.setattr(HilIn, 'gz', rocket.rotation_rate(3));
py.setattr(HilIn, 'p', rocket.atmosphere.pressure * 1e-3);
py.setattr(HilIn, 'awaiting_init', false);
py.setattr(HilIn, 'awaiting_launch', true);

% Correctly assign HilIn to FjalarData using CopyFrom
py.getattr(FjalarData, 'hil_in').CopyFrom(HilIn);

% Assign FjalarData to FjalarMessage
py.getattr(FjalarMessage, 'data').CopyFrom(FjalarData);
write(rocket.serialport, encode_message(FjalarMessage), "uint8")
end