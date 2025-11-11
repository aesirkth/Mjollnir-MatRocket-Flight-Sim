if ~exist("rocket_historians", "var")
load("monte_carlo.mat")
end
impact_positions = cellfun(@(h) h.position(:,:,end), rocket_historians(1:sim_nr-2) , 'UniformOutput', false);
impact_positions = cell2mat(impact_positions);

pdf = multivariable_normal_distribution(impact_positions(1:2,:));

[X,Y] = meshgrid(-10000:100:10000,-10000:100:10000);
x = [reshape(X,[],numel(X));reshape(Y,[], numel(Y))];

p = pdf(x);

P = reshape(p, size(X));

contour3(X,Y,P, 1e-10:3e-9:1e-7); 
hold on; view([0,90]); xlim([-6000 6000]);ylim([-6000 6000]);
%surf(X,Y,P);
scatter(impact_positions(1,:), impact_positions(2,:));
