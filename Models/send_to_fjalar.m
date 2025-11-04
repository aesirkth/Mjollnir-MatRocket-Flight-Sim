function rocket = send_to_fjalar(rocket)

persistent init


if isempty(init)

%% Do all the initiation shit here, runs on first simulation iteration


init = false;
end



FjalarMessage = rocket.HIL.protobuf.FjalarMessage();
FjalarData    = rocket.HIL.protobuf.FjalarData();
HilIn         = rocket.HIL.protobuf.HilIn();

% Populate HilIn fields
py.setattr(HilIn, 'ax', rocket.acceleration(1));
py.setattr(HilIn, 'ay', rocket.acceleration(2));
py.setattr(HilIn, 'az', rocket.acceleration(3));
py.setattr(HilIn, 'gx', rocket.rotation_rate(1));
py.setattr(HilIn, 'gy', rocket.rotation_rate(2));
py.setattr(HilIn, 'gz', rocket.rotation_rate(3));
py.setattr(HilIn, 'p', rocket.atmosphere.pressure * 1e-3);

% Correctly assign HilIn to FjalarData using CopyFrom
py.getattr(FjalarData, 'hil_in').CopyFrom(HilIn);

% Assign FjalarData to FjalarMessage
py.getattr(FjalarMessage, 'data').CopyFrom(FjalarData);

end