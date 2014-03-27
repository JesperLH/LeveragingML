function [X,y] = generateData(N,p,type)
%% Covariance matrix

sigma = zeros(p,p);
for i = 1:p
    for j = 1:p
        sigma(i,j) = 2*0.5^abs(i-j);
    end
end

%% 
if (p < 20)
    B = ones(1,p)';
else
    B = [ones(1,10), 0.1*ones(1,p-20), ones(1,10)]';
end

%%
switch type
    case 'GA'
        X = mvnrnd(ones(p,1),sigma,N);
    case 'T1'
        X = mvtrnd(sigma,1,N); %T dist Data with zero mean
    case 'T3'
        X = mvtrnd(sigma,3,N); %T dist Data with zero mean
end
noise = randn(N,1)*sqrt(9); 

y = X*B+noise;
end