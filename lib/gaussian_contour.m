function [ellipse_set, mu] = gaussian_contour(impact_points, alpha)
%This function takes the impact_points as a parameter, where impact_points is formatted as:
% [E1, ..]
% [N1,...]

% In other words, the impact_points is a matrix containing the coordinate (ENU) of each impact as a vector.



%% mean vector mu is the vector mean of the coordinates [E~; N~]
mu = mean(impact_points, 2); 



%% find the covariance matrix of our data points


% https://www.mathworks.com/help/matlab/ref/cov.html
%"If A is a matrix whose columns represent random variables and whose rows represent observations, C is the covariance matrix with the corresponding column variances along the diagonal."


covariance_matrix = cov(impact_points.');

%% 
% For a multivariable probability distribution, a contour ellipse is
% defined as pdf f(x) = C (constant)
% Equivalent (x - μ)ᵀ Σ⁻¹ (x - μ) = k from multivar gaussian pdf definition
% Q(x) := (x - μ)ᵀ Σ⁻¹ (x - μ) ~ χ²_f (where f=2)
% Means we find k such that P(Q<=k) = α

% chi squared distribution is closed form for f=2
k = -2 * log(1 - alpha);
  

%% Eigen-decomposition
% https://se.mathworks.com/help/matlab/ref/eig.html
% "[V,D] = eig(A) returns diagonal matrix D of eigenvalues and matrix V
% whose columns are the corresponding right eigenvectors, so that A*V = V*D."
% Covariance matrix is symmetric --> Spectral theorem
[V,D] = eig(covariance_matrix);

% circle
theta = linspace(0, 2*pi, 360);
circle = [cos(theta); sin(theta)];

% Ellipse
ellipse_set = mu + V * sqrt(D * k) * circle;
%disp(ellipse_set);
end


%% notes from statistics:

% Let X be a random variable vector with states [X_1, X_2] which are also  random variables.

%Then, Cov(X) is defined as
% Cov(X) = E[(X-μ)(X-μ)ᵀ]

% Let X be a random variable  ~𝒩(μ,σ²),
% Then, X-μ / σ  ~𝒩(0,1)

% If X_1, X_2, ... X_f are independent 𝒩(0,1)
% Then X²₁ + X²₂ ...  ~χ²


% Let X be a 2D random vector, X = [X_E; X_N]
% Then, mean vector is μ = E[X], where the expectation operator is applied to each element

% The covariance matrix is: Σ = Cov(X) = E[(X - μ)(X - μ)ᵀ]


% If X ~ 𝒩(μ, σ²) then Z = (X - μ) / σ ~ 𝒩(0,1)
% 1D: Q := (X - μ)² / σ² = Z² ~ χ²_f
% In vector form:
% Q(x) = (x - μ)ᵀ Σ⁻¹ (x - μ)

% Contour constant probability: (x - μ)ᵀ Σ⁻¹ (x - μ) = k
% k is some chi-squared value


% Principal axes theorem + eigen decomposition Σ = VDVᵀ
% ellipse = μ + V * sqrt(k D) * [cosθ; sinθ]

%%