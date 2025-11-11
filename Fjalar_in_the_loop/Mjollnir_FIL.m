function rocket = Mjollnir_FIL()

rocket = Mjollnir();

rocket.models = {rocket.models{:}, @send_to_fjalar};

rocket.HIL = struct();
rocket.HIL.protobuf = py.importlib.import_module('schema_pb2');
rocket.serialport = serialport('COM7', 115200);

clear send_to_fjalar