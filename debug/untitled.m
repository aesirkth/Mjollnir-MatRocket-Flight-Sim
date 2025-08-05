
% Create a FjalarMessage object
msg = protobuf.FjalarMessage();

% Set primitive fields
msg.time = uint8([1 2 3 4]);               % Assuming time is bytes
msg.sequence_number = int32(42);

% Create and set a nested HilIn message
hilIn = protobuf.HilIn();
hilIn.airbrake_percentage = single(0.85);
hilIn.main_deployed = true;
hilIn.drogue_deployed = false;

% Assign it to the data.hil_in field
fjalarData = protobuf.FjalarData();
fjalarData.hil_in = hilIn;

msg.data = fjalarData;

% Display the message
disp(msg);