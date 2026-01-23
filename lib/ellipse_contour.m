N = 500;

A = [2.5 1.2;
     0.3 0.4];

impact_points = A * randn(2, N);

alphas = 0.95:-0.05:0.80;   % 95%, 90%, 85%, 80%

figure; 
hold on; 
axis equal; 
grid on;

scatter(impact_points(1,:), impact_points(2,:), 5, 'filled');

mu = mean(impact_points, 2);
plot(mu(1), mu(2), 'kx', 'LineWidth', 2);

colors = lines(length(alphas));

for i = 1:length(alphas)
    alpha = alphas(i);
    [ellipse, ~] = multivariable_normal_ellipse(impact_points, alpha);
    plot(ellipse(1,:), ellipse(2,:), 'LineWidth', 1, 'Color', colors(i,:));
end

legend(["Samples", "Mean", "95%", "90%", "85%", "80%"]);
