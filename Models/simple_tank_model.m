function rocket = simple_tank_model(rocket)
liquid_mass     = rocket.tank.liquid.mass      *(rocket.engine.burn_time - rocket.t)/rocket.engine.burn_time;
fuel_grain_mass = rocket.engine.fuel_grain.mass*(rocket.engine.burn_time - rocket.t)/rocket.engine.burn_time;
rocket.tank.liquid.mass       = liquid_mass    *( liquid_mass     > 0);
rocket.engine.fuel_grain.mass = fuel_grain_mass*( fuel_grain_mass > 0);

end