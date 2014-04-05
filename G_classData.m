clear all
close all
clc

p = 2; % number of dimensions
N = 1000; % number of datapoints
r = 10; % sample size
type = 'T3';
clusterDistribution = 0.5;

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

N1 = round(N*clusterDistribution);
N2 = N-N1;

D = [repmat(-D,N1,1);repmat(D,N2,1)];

X = X+D;

t = [-ones(N1,1); ones(N2,1)];


if (size(X,2) == 2)
    figure
    plot(X(1:N1,1),X(1:N1,2),'.b',X(N2+1:N,1),X(N2+1:N,2),'.r')
    legend('Class 1', 'Class 2');
    title(sprintf('Simulated data\n %s distribution',type));
end

%% Random permutation for more realism

R = randperm(N);

X = X(R,1:size(X,2));
t = t(R);

%% "Logistic" regression

%The "leverage" distribution
%Same as for linear regression, but multiplied by targets (t)
H = X*inv(X'*X)*X';

figure
bar(sort(diag(H).*t));

%Finding the distribution, we take abs((H)
pi = abs(diag(H))./sum(abs(diag(H)));
if (p == 2) 
    [w_est, w_estH, logSumErr, logSumErrH , correct, correctH] = SubsampleLogReg( X,t,pi,r , true);
    [w_estU, w_estHU, logSumErrU, logSumErrHU , correctU, correctHU] = SubsampleLogReg(X,t,ones(N,1)/N,r,true);
else
    [w_est, w_estH, logSumErr, logSumErrH , correct, correctH] = SubsampleLogReg( X,t,pi,r , true);
    [w_estU, w_estHU, logSumErrU, logSumErrHU , correctU, correctHU] = SubsampleLogReg(X,t,ones(N,1)/N,r,true);
end
[correct correctH; correctU correctHU]
[logSumErr logSumErrH; logSumErrU logSumErrHU]

y = t;
y(t<0) = 0;
l=glmval(glmfit(X,y,'binomial'),X,'logit');
l(l<0.5) = 0;
l(l>0.5) = 1;
sum(l == y)