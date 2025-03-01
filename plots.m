mag = @(v) sqrt(v(1,:).^2 + v(2,:).^2 + v(3,:).^2);

disp("Printout:__________________________________")
disp("Max-altitude:")
disp(string(max(rocket_historian.position(3,:))) + " m")
disp("Max-velocity (groundspeed):")
disp(string(max(mag(rocket_historian.velocity))) + " m/s")
disp("Max-velocity (groundspeed):")
disp(string(max(mag(rocket_historian.velocity - rocket_historian.enviroment.wind_velocity))) + " m/s")

figure("name", "trajectory");
ax1 = subplot(1,2,1);
ax1.NextPlot = "add";
plot3(ax1, 0,0,0)
drawnow
vectorplot(ax1, rocket_historian.position);
vectorplot(ax1, rocket_historian.position.*[1;1;0]); % Projection
vectorplot(ax1, rocket_historian.position.*[0;1;1]);
vectorplot(ax1, rocket_historian.position.*[1;0;1]);
title(ax1, "Trajectory");
xlabel(ax1, "x [m]"); ylabel(ax1, "y [m]"); zlabel(ax1, "z [m]");
grid(ax1, "on");
axis(ax1, "equal"); axis(ax1, "padded")
view(ax1, 45,45)
ax1.NextPlot = "replacechildren";
drawnow


ax2 = subplot(2,2,2);
ax2.NextPlot = "add";
plot3(ax2, 0,0,0)

vectorplot(ax2, rocket_historian.position.*[1;0;1]);
title(ax2, "Trajectory");
xlabel(ax2, "x [m]"); ylabel(ax2, "y [m]"); zlabel(ax2, "z [m]");
grid(ax2, "on");
view(ax2, 0,0)
ax2.NextPlot = "replacechildren";
drawnow



ax3 = subplot(2,2,4);
ax3.NextPlot = "add";
plot3(ax3, 0,0,0)

vectorplot(ax3, rocket_historian.position.*[0;1;1]);
title(ax3, "Trajectory");
xlabel(ax3, "x [m]"); ylabel(ax3, "y [m]"); zlabel(ax3, "z [m]");
grid(ax3, "on");
view(ax3, 90,0)
ax3.NextPlot = "replacechildren";
drawnow


figure("name", "altitude")

ax4 = subplot(1,2,2);
ax4.NextPlot = "add";
plot(ax4, rocket_historian.t, rocket_historian.enviroment.air_density);
title(ax4, "air-density over time")
xlabel(ax4, "time [s]"); ylabel(ax4, "air-density kg/m^3")
grid(ax4, "on")
drawnow

ax5 = subplot(1,2,1);
ax5.NextPlot = "add";
plot(ax5, rocket_historian.t, rocket_historian.position(3,:));
title(ax5, "altitude over time")
xlabel(ax5, "time [s]"); ylabel(ax5, "altitude [m]")
grid(ax5, "on")
drawnow


figure("name", "velocity")

ax6 = subplot(1,2,1);
ax6.NextPlot = "add";
plot(ax6, rocket_historian.t, mag(rocket_historian.velocity));
plot(ax6, rocket_historian.t, mag(rocket_historian.velocity - rocket_historian.enviroment.wind_velocity));
title(ax6, "velocity over time")
legend(ax6, "ground-speed", "air-speed")
xlabel(ax6, "time [s]"); ylabel(ax6, "velocity [m/s]")
grid(ax6, "on");
drawnow


mach = @(v) v/343.2;

ax7 = subplot(1,2,2);
mag = @(v) sqrt(v(1,:).^2 + v(2,:).^2 + v(3,:).^2);
ax7.NextPlot = "add";
plot(ax7, rocket_historian.t, mach(mag(rocket_historian.velocity - rocket_historian.enviroment.wind_velocity)));
title(ax7, "Mach over time")
legend(ax7, "air-speed")
xlabel(ax7, "time [s]"); ylabel(ax7, "Mach")
grid(ax7, "on");
drawnow


figure("name", "mass")

ax8 = subplot(1,2,1);
ax8.NextPlot = "add";
plot(ax8, rocket_historian.t, rocket_historian.mass_absolute);
plot(ax8, rocket_historian.t, rocket_historian.tank.mass_absolute);
plot(ax8, rocket_historian.t, rocket_historian.tank.liquid.mass_absolute);
title(ax8, "Mass over time")
legend(ax8, "Total mass", "Tank mass", "Oxidizer mass")
xlabel(ax8, "time [s]"); ylabel(ax8, "mass [kg]")
grid(ax8, "on");
drawnow

ax9 = subplot(1,2,2);
ax9.NextPlot = "add";
mesh = stlread(".\Rocket_source\Mjollnir\Mjollnir_mesh.stl");
patch(ax9, mesh, 'FaceColor', [0,0.2,0.2], ...
    'EdgeColor',       'none',        ...
    'FaceLighting',    'gouraud',     ...
    'AmbientStrength', 0.6, ...
    'FaceAlpha',       0.05);
light(ax9)
center_of_mass_normal_basis = zeros(size(rocket_historian.center_of_mass_absolute));
for i = 1:width(center_of_mass_normal_basis); center_of_mass_normal_basis(:,i) = (reshape(rocket_historian.attitude(:,i),3,3)')*rocket_historian.center_of_mass_absolute(:,i);end

vectorplot(ax9, center_of_mass_normal_basis, 'LineWidth', 1.4, 'LineStyle', '-', 'Marker', '.');
vectorscatter(ax9, center_of_mass_normal_basis(:,1));
vectorscatter(ax9, center_of_mass_normal_basis(:,end));
vectorplot(ax9, rocket_historian.tank.center_of_mass_absolute, 'LineWidth', 1.4, 'LineStyle', '-', 'Marker', '.');
vectorscatter(ax9, rocket_historian.tank.center_of_mass_absolute(:,1), 'd');
vectorscatter(ax9, rocket_historian.tank.center_of_mass_absolute(:,end), 'd');
title(ax9, "Center-of-mass over time")
axis(ax9, 'equal'); axis(ax9, 'padded'); 
xlabel(ax9, "x [m]"); ylabel(ax8, "y [m]"); ylabel(ax8, "z [m]")
legend(ax9, 'Mjollnir', 'Total center-of-mass', 'Total start',   'Total end', ...
                        'Tank center-of-mass' ,  'Tank start',   'Tank end')
grid(ax9, "on");
view(ax9, 45,45);
drawnow

figure("name", "forces")

ax10 = subplot(1,2,1);
ax10.NextPlot = "add";
plot(ax10, rocket_historian.t, mag(rocket_historian.force_absolute.vec))
plot(ax10, rocket_historian.t, mag(rocket_historian.Mjollnir_mesh.force_absolute.vec))
plot(ax10, rocket_historian.t, mag(rocket_historian.engine.force_absolute.vec))
plot(ax10, rocket_historian.t, mag(rocket_historian.forces.Gravity.vec))
title(ax10, "Force over time")
xlabel(ax10, "time [s]"); ylabel(ax10, "force [N]");
legend(ax10, "Total", "Lift", "Thrust", "Gravity");

ax11 = subplot(1,2,2);
ax11.NextPlot = "add";

plot(ax11, rocket_historian.t, rocket_historian.Mjollnir_mesh.lift_force_tensor(2,:));
plot(ax11, rocket_historian.t, rocket_historian.Mjollnir_mesh.lift_force_tensor(3,:));
plot(ax11, rocket_historian.t, rocket_historian.Mjollnir_mesh.lift_force_tensor(4,:));
plot(ax11, rocket_historian.t, rocket_historian.Mjollnir_mesh.lift_force_tensor(6,:)+1e3);
plot(ax11, rocket_historian.t, rocket_historian.Mjollnir_mesh.lift_force_tensor(7,:)+1e3);
plot(ax11, rocket_historian.t, rocket_historian.Mjollnir_mesh.lift_force_tensor(8,:)+1e3);
title(ax11, "Aerodynamic lift")
xlabel(ax11, "time [s]"); ylabel(ax11, "force [N]");
legend(ax11, "xy", "xz", "yx", "yz+1e3", "zx+1e3", "zy+1e3");

figure("name", "energy")
ax12 = subplot(1,2,1);
ax12.NextPlot = "add";
plot(ax12, rocket_historian.t, mag(rocket_historian.velocity).*mag(rocket_historian.force_absolute.vec));
plot(ax12, rocket_historian.t, mag(rocket_historian.velocity).*mag(rocket_historian.Mjollnir_mesh.force_absolute.vec));
plot(ax12, rocket_historian.t, mag(rocket_historian.velocity).*mag(rocket_historian.engine.force_absolute.vec));
plot(ax12, rocket_historian.t, mag(rocket_historian.velocity).*mag(rocket_historian.forces.Gravity.vec));

title(ax12, "dWork/dt")
xlabel(ax12, "time [s]"); ylabel(ax12, "power [W]");
legend(ax12, "Total", "Aerodynamics", "Thrust", "Gravity")

ax13 = subplot(1,2,2);
ax13.NextPlot = "add";
plot  (ax13, rocket_historian.t, 0.5*(mag(rocket_historian.velocity).^2).*rocket_historian.mass_absolute + rocket_historian.mass_absolute.*rocket_historian.enviroment.g.*rocket_historian.position(3,:) )
title (ax13, "Energy/Work")
xlabel(ax13, "time [s]"); ylabel(ax12, "Energy [J]");
legend(ax13, "Total")



figure("name", "rotation")
ax14 = subplot(1,2,1);
rotation_rate = zeros(size(rocket_historian.rotation_rate));
for i = 1:width(rotation_rate); rotation_rate(:,i) = (reshape(rocket_historian.attitude(:,i),3,3)')*rocket_historian.rotation_rate(:,i);end
plot(ax14,rocket_historian.t, rocket_historian.rotation_rate)
title(ax14, "rotation-rate \omega")
xlabel(ax14, "t [s]"); ylabel(ax14, "revs/s [Hz]");

