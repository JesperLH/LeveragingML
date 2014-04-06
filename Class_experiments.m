
clear all
close all
clc

p = 2; % number of dimensions
N = 1000; % number of datapoints
r = 20; % sample size
type = 'T3';
clusterDistribution = 0.5;

distance = 1.3; % manual konstant
Generate_classData;

%% "Logistic" regression

%The "leverage" distribution
%Same as for linear regression,
H = X*inv(X'*X)*X'; 

figure
bar(sort(diag(H).*t));

%%Finding the distribution, we take abs((H)
pi = abs(diag(H))./sum(abs(diag(H)));
if (p == 2) 
    [Plin, Pglm, idx] = SubsampleLogReg( X,t,pi,r);
    [PlinU, PglmU, idxU] = SubsampleLogReg(X,t,ones(N,1)/N,r);
else
    [Plin, Pglm, idx] = SubsampleLogReg( X,t,pi,r);
    [PlinU, PglmU, idxU] = SubsampleLogReg(X,t,ones(N,1)/N,r);
end


%% Ilustrates the example if two-dimensional

if size(X,2) == 2 && showPlots
    illustrate2D2Class(X,t,idx);
end

    figure
    subplot 311
    plot(1:N,Pglm,'.b',1:N,Plin,'.r');
    title('Logistic regression in Matlab vs. Homebrew');
    xlabel('Observations sorted acoording to probability of beloing to class 1')
    ylabel('Estimated target value, class 1 is > 0, class 2 < 0')
    legend('Log-reg Matlab','Homebrew');
    
    %Sorted acoording to Plin
    subplot 312
    [igno index] = sort(Plin); clear igno;
    plot(1:N,Pglm(index),'.b',1:N,Plin(index),'.r');
    title('Logistic regression in Matlab vs. Homebrew');
    xlabel('Observations sorted acoording to probability of beloing to class 1')
    ylabel('Estimated target value, class 1 is > 0, class 2 < 0')
    legend('Log-reg Matlab','Homebrew');
    
    %Sorted acoording to P
    subplot 313
    [igno index] = sort(Pglm); clear igno;
    plot(1:N,Pglm(index),'.b',1:N,Plin(index),'.r');
    title('Logistic regression in Matlab vs. Homebrew');
    xlabel('Observations sorted acoording to probability of beloing to class 1')
    ylabel('Estimated target value, class 1 is > 0, class 2 < 0')
    legend('Log-reg Matlab','Homebrew');

