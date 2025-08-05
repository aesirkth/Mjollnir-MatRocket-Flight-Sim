function rocket = send_to_fjalar(rocket)
persistent init
persistent message

if isempty(init)
    message = protobuf.FjalarMessage();
    init = false;
end


clear_que(rocket.Fjalar.output_stream);
send(rocket.Fjalar.output_stream, message);

end