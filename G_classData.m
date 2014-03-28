clear
close
clc

p = 2; % number of dimensions
N = 1000; % number of datapoints
type = 'GA';

distance = 1.3; % manual konstant

%% Covariance matrix

sigma = zeros(p,p);
for i = 1:p
    for j = 1:p
        sigma(i,j) = 2*0.5^abs(i-j);
    end
end

%% Difference between clusters

D = randn(1,p);
D = D./norm(D)*2*distance;


switch type
    case 'GA'
        X = mvnrnd(zeros(p,1),sigma,N);
    case 'T1'
        X = mvtrnd(sigma,1,N); %T dist Data with zero mean
    case 'T3'
        X = mvtrnd(sigma,3,N); %T dist Data with zero mean
end

N1 = round(N/2);
N2 = N-N1;

D = [repmat(-D,N1,1);repmat(D,N2,1)];

X = X+D;

t = [-ones(N1,1); ones(N2,1)];


plot(X(:,1),X(:,2),'.')

%% Random permutation for more realism

R = randperm(N);

X = X(R);
t = t(R);



