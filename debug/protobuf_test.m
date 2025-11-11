
% Create top-level message
msg = protobuf.FjalarMessage();

py.setattr(msg, 'sequence_number', int32(1234));

% Create submessage
hilIn = protobuf.HilIn();
hilIn.airbrake_percentage = single(0.85);
hilIn.main_deployed = true;
hilIn.drogue_deployed = false;

% Wrap in container
data = protobuf.FjalarData();
data.hil_in = hilIn;

% Assign nested message
msg.data = data;

% Serialize
bytes = msg.SerializeToString();

% Deserialize
parsed = protobuf.FjalarMessage();
parsed.ParseFromString(bytes);

% Inspect fields
disp(parsed.sequence_number)
disp(parsed.data.hil_in.airbrake_percentage)