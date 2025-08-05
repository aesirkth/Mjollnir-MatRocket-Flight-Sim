function pdf = multivariable_normal_distribution(X)

 

X_mean = sum(X,2, "omitmissing")/size(X,2);

covariance = zeros(size(X,1),size(X,1));

for i = 1:height(covariance)
for j = 1: width(covariance)

covariance(i,j) = ( 1 / size(X,2) )*sum( (X(i,:) - X_mean(i) ).*(X(j,:) - X_mean(j) ) , 2, "omitmissing");

end
end

pdf = @(x) pdf_internal(x);


function p = pdf_internal(x)
p = zeros(1,size(x,2));
for n = 1:size(x,2)
p(n) = exp(-0.5*(x(:,n) - X_mean)' * (covariance\(x(:,n) - X_mean) ) )/sqrt( (2*pi)^size(x,1)*det(covariance) );
end
end


end