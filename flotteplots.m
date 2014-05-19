clear all
close all
clc

p = 2; % number of dimensions
N = 100; % number of datapoints
r = 10; % sample size
type = 'T3';
[X, y] = generateData(N,p,type);


%% "Logistic" regression

%The "leverage" distribution
%Same as for linear regression,
H = X*inv(X'*X)*X'; 

pi = abs(diag(H))./sum(abs(diag(H)));
%Leverage sampling
[~ ,err, idx] = SubsampleLS( X,y,pi,r);

%uniform sampling
[~, errUni, idxUniform] = SubsampleLS( X,y,ones(N,1)/N,r);

%% Ilustrates the example if two-dimensional
%Find axis
xmin = min(X(:,1))-3;
xmax = max(X(:,1))+3;
ymin = min(X(:,2))-3;
ymax = max(X(:,2))+3;

%% Plot
figure
%First plot the sampled data
hold on
plot(X(idx,1),X(idx,2),'or','markerSize',16);
plot(X(idxUniform,1),X(idxUniform,2),'xk','markerSize',16,'Linewidth', 2);
plot(X(:,1),X(:,2),'.b','markerSize',16,'Linewidth', 2);
axis([xmin xmax ymin ymax])
legend('Class 1');
title('Sample data points');
xlabel('x'); ylabel('y');
hold off
[err, errUni]

