function rocket = Mjollnir()

    rocket                  = txt2struct('.\Rocket_source\Mjollnir\Mjollnir.txt');
    rocket.name             = "reference_rocket";
    rocket.dont_record      = ["", ""];
    rocket.models           = {@simple_tank_model,   ...
                               @equations_of_motion, ...
                               @propulsion_model,    ...
                               @aerodynamics_model,  ...
                               @gravity_model,       ...
                               @equations_of_motion    };
    
    
    rocket.derivative = containers.Map();
    
    
    
    %% Enviroment & physical constants
    
    rocket.enviroment                      = struct();
    rocket.enviroment.position             = [0;0;0];
    rocket.enviroment.g                    = 9.81;
    rocket.enviroment.temperature          = 282;
    rocket.enviroment.wind_velocity        = [0;0;0];

    
    
    
    %% Rigid-body model
    rocket.rigid_body                        = body();
    rocket.rigid_body.position               = [-0.105; -0.239; 1300.706]*1e-3;
    rocket.rigid_body.mass                   = 41;
    rocket.rigid_body.moment_of_inertia      = [ 6.148e10, -2.485e5,  -1.571e6;
                                                -2.485e5,   6.148e10, -3.588e6;
                                                -1.571e6,  -3.588e6,   2.047e8]*1e-9;
    
    
    
    
    rocket.forces                        = struct();
    rocket.moments                       = struct();
    rocket.attitude                      = eye(3);                                  rocket.derivative("attitude")         = zeros(3);
    rocket.angular_momentum              = zeros(3,1);                              rocket.derivative("angular_momentum") = zeros(3,1);
    rocket.rotation_rate                 = zeros(3,1);
    rocket.position                      = [0;0;0];                                 rocket.derivative("position")         = zeros(3,1);
    rocket.velocity                      = zeros(3,1);                              rocket.derivative("velocity")         = zeros(3,1);
    
    
    rocket.forces.null                   = force ([0;0;0], [0;0;0]);
    rocket.moments.null                  = moment([0;0;0], [0;0;0]);
    
    
    
    
    
    %% Aerodynamics-model
    
    rocket                                                 = mesh2aerodynamics(rocket);
    rocket.Mjollnir_mesh.aerodynamics.pressure_coefficient = [0.6;0.6;0.4];
    
    rocket.engine.burn_time                     = 15;
    rocket.engine.thrust_force                  = 4e3;
    rocket.engine.fuel_grain                    = struct();
    rocket.engine.fuel_grain.mass               = 4.3;
    rocket.engine.fuel_grain.position           = [0;0;0.3];
    
    
    
    
    rocket.recovery_system            = body();
    rocket.recovery_system.shute      = struct();
    rocket.recovery_system.shute.mass = 0.75+0.791+0.275;
    rocket.recovery_system.position   = [0;0;3.2];
    
    rocket.tank = body();
    rocket.tank.position    = [0;0;2];
    rocket.tank.liquid      = body();
    rocket.tank.liquid.mass = 27.0;

    