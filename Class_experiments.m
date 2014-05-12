
clear all
close all
clc

p = 2; % number of dimensions
N = 1000; % number of datapoints
r = 30; % sample size
type = 'T3';
clusterDistribution = 0.5;

distance = 1.3; % manual konstant
Generate_classData;

%% "Logistic" regression

%The "leverage" distribution
%Same as for linear regression,
H = X*inv(X'*X)*X'; 

figure
bar(sort(log(diag(H)).*t))
xlabel('Observations')
ylabel('log( h_{i i} ) multiplied by t_i ')
axis tight

%% Finding the distribution, we take abs((H)
pi = abs(diag(H))./sum(abs(diag(H)));
[Plin, Pglm, idx] = SubsampleLogReg( X,t,pi,r);


%% Ilustrates the example if two-dimensional

if size(X,2) == 2 
    %Illustration for LS-leverage-based distribution on classification
    illustrate2D2Class(X,t,idx);
    
    [~ , ~, idxUniform] = SubsampleLogReg( X,t,ones(N,1),r);
    illustrate2D2Class(X,t,idxUniform);
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

