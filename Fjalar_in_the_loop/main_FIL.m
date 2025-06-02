
my_rocket = Mjollnir_FIL();
my_rocket.enviroment.wind_velocity = [2;0;0];




% Communication
comport = serialport("COM3", 9600);

thread_manager = struct();
thread_manager.A2B = parallel.pool.PollableDataQueue(Destination="any");      % Client -> Worker
thread_manager.B2A = parallel.pool.PollableDataQueue(Destination="any");      % Worker -> Client

logTask = parfeval(@FlightSimulationThread, 0, my_rocket, thread_manager);



thread_A_status    = "NOT STARTED";
thread_B_status    = "NOT STARTED";
instructed_angle   = [0;0];
new_output_data    = true;
message            = poll(my_rocket.Fjalar.output_stream);


disp("CHECK 1")








while ~isequal(thread_B_status, "FINISHED")

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Read from hardware

    clear_que(my_rocket.Fjalar.input_stream)
    %send(my_rocket.Fjalar.input_stream,  {"angle", angle})

    message = poll(my_rocket.Fjalar.output_stream);

    if ~isempty(message) % new message
        
        local_acceleration  = message{1};
        local_rotation_rate = message{2};
        pressure            = message{3};
        message_string      = "acc"+strjoin(string(local_acceleration), ",")+"rot"+strjoin(string(local_rotation_rate))+"pre"+strjoin(string(pressure));
        write(comport, message_string, "string");
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SERIAL STUFF


    end




    % Inter-thread communication
    if isequal(thread_A_status, "NOT STARTED")
    send(thread_manager.A2B, {"RUNNING"})
    thread_A_status = "RUNNING"
    end

    B2A_message = poll(thread_manager.B2A);
    if ~isempty(B2A_message)
    thread_B_status = B2A_message{1}
    end



end



%% Thread B
function FlightSimulationThread(my_rocket, thread_manager)
    
    disp("CHECK 2")

    thread_A_status    = "NOT STARTED";
    thread_B_status    = "NOT STARTED";
    

    while isequal(thread_A_status, "NOT STARTED") % HOLDING PATTERN

        A2B_message = poll(thread_manager.A2B)
        if ~isempty(A2B_message)
        thread_A_status = A2B_message{1}
        end

    end

    thread_B_status = "RUNNING";
    send(thread_manager.B2A, {"RUNNING"})
    
    

    disp("CHECK 3")


    job = struct(); job.t_max = 25; job.ode_solver = @realtime_ode;

    rocket_historian = run_simulation(my_rocket, job);
    if isfile(".\Output\flight.csv")
    delete(".\Output\flight.csv");
    end
    obj2csv(".\Output\flight.csv", query_historian(rocket_historian, 0:1/60:job.t_max))
    plots

    thread_B_status = "FINISHED";
    send(thread_manager.B2A, {"FINISHED"})

end
