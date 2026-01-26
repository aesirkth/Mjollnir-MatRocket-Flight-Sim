function ellipses = confidence_interval(impact_points, alphas)
% impact_points - 2xN impact points in ENU (ie. 2 rows, N columns)
% alphas - confidence level vector ([0.95 0.90 0.85... etc])
% ellipses - struct (alpha, points, mean)

% mean might be unnecessary in the struct, since it could just be computed in plot_impact_distribution.m 

    mu = mean(impact_points, 2);
    ellipses = struct([]);

    for i = 1:length(alphas)
        alpha = alphas(i);
        [ellipse, ~] = gaussian_contour(impact_points, alpha);

        ellipses(i).alpha  = alpha;
        ellipses(i).points = ellipse;
        ellipses(i).mean   = mu;
    end
end
