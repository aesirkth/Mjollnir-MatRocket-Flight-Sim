if ~exist("rocket_historians", "var")
load("monte_carlo.mat")
end
impact_positions = cellfun(@(h) h.position(:,:,end), rocket_historians(1:sim_nr-2) , 'UniformOutput', false);
impact_positions = cell2mat(impact_positions);

%pdf = multivariable_normal_distribution(impact_positions(1:2,:));

%[X,Y] = meshgrid(-10000:100:10000,-10000:100:10000);
%x = [reshape(X,[],numel(X));reshape(Y,[], numel(Y))];

%p = pdf(x);

%P = reshape(p, size(X));

%contour3(X,Y,P, 1e-10:3e-9:1e-7); 
%hold on; view([0,90]); xlim([-6000 6000]);ylim([-6000 6000]);
%surf(X,Y,P);

% Geomapping
figure;
wgs84 = wgs84Ellipsoid('meters');
geobasemap satellite

% Launch site
lat0 = 67.889663108;
lon0 = 21.10416625;
alt0 = 341;
geoscatter(lat0, lon0, 30, 'g', 'filled');
text(lat0, lon0, ' Launch site', 'VerticalAlignment','bottom', 'HorizontalAlignment','left', 'Color','w');
hold on;

% Impact zone A
latA = [67.8723008, 67.8723084, 67.8723660, 67.8780572, 67.8801491, 67.8821042, 67.8832564, 67.8844700, 67.9101134, 67.9532620, 67.9761755, 67.9173745, 67.8996103, 67.8723008];
longA = [21.0393914, 21.0515890, 21.1438720, 21.1521476, 21.1521790, 21.1562466, 21.1614810, 21.1614749, 21.1987985, 21.1982443, 20.9897495, 20.9880485, 21.0275520, 21.0393914];
geoplot(latA, longA,'--', LineWidth=1);
text(67.9101134, 21.1987985, ' Impact zone A', 'VerticalAlignment','bottom', 'HorizontalAlignment','left', 'Color','w');

% Convert ENU coordinates to geodetic
[lat, lon, alt] = enu2geodetic(impact_positions(1,:), impact_positions(2,:), zeros(1, size(impact_positions,2)), lat0, lon0, alt0, wgs84);

% Plot impact points
geoscatter(lat, lon, 30, 'r');

%scatter(impact_positions(1,:), impact_positions(2,:));