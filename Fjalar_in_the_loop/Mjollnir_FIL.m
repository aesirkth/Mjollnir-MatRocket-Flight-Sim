function rocket = Mjollnir_FIL()

rocket = Mjollnir();

rocket.models = {rocket.models{:}, @send_to_fjalar};

rocket.HIL = struct();
rocket.HIL.protobuf = py.importlib.import_module('schemamatrocket_pb2');
%rocket.serialport = serialport('COM4', 115200);
