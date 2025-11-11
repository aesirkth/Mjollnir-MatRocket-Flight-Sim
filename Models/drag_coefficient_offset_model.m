function rocket = drag_coefficient_offset_model(rocket)

if isfield(rocket.aerodynamics, "drag_coefficient_offset")
rocket.aerodynamics.pressure_coefficient = rocket.aerodynamics.pressure_coefficient.*rocket.aerodynamics.drag_coefficient_offset;
end

end